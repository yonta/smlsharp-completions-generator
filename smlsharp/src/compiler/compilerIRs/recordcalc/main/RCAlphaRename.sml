(**
 * @copyright (C) 2021 SML# Development Team.
 * @author Atsushi Ohori
 *)
structure RCAlphaRename =
struct
local
 
  structure RC = RecordCalc
  structure TC = TypedCalc
  structure T = Types
  structure P = Printers
  fun bug s = Bug.Bug ("RCAlphaRename: " ^ s)

  val print = fn s => if !Bug.printInfo then print s else ()
  fun printRcexp rcexp = 
      print (Bug.prettyPrint (RC.format_rcexp rcexp))

  exception DuplicateVar
  exception DuplicateBtv


  type ty = T.ty
  type varInfo = RC.varInfo

  type path = RC.path
  type longsymbol = Symbol.longsymbol
  type btvEnv = T.kind BoundTypeVarID.Map.map
  type rcexp = RC.rcexp

  type btvMap = BoundTypeVarID.id BoundTypeVarID.Map.map
  val emptyBtvMap = BoundTypeVarID.Map.empty
  type varMap = VarID.id VarID.Map.map
  val emptyVarMap = VarID.Map.empty
  type catchMap = FunLocalLabel.id FunLocalLabel.Map.map
  val emptyCatchMap = FunLocalLabel.Map.empty
  type context = {varMap:varMap, btvMap:btvMap, catchMap:catchMap}
  val emptyContext = {varMap=emptyVarMap, btvMap=emptyBtvMap,
                      catchMap=emptyCatchMap}

  fun copyTy (context:context) (ty:ty) = 
      TyAlphaRename.copyTy (#btvMap context) ty
      handle exn =>
             (P.print "TyAlphaRename exception";
              P.printTy ty;
              P.print "\n";
              raise exn
             )
  fun newBtvEnv ({varMap, btvMap, catchMap}:context) (btvEnv:btvEnv) =
      let
        val (btvMap, btvEnv) = 
            TyAlphaRename.newBtvEnv btvMap btvEnv
      in
        ({btvMap=btvMap, varMap=varMap, catchMap=catchMap}, btvEnv)
      end
  fun copyExVarInfo context {path:path, ty:ty} =
      {path=path, ty=copyTy context ty}
  fun copyPrimInfo context {primitive : BuiltinPrimitive.primitive, ty : ty} =
      {primitive=primitive, ty=copyTy context ty}
  fun copyOprimInfo context {ty : ty, path : path, id: OPrimID.id} =
      {ty=copyTy context ty, path=path,id=id}
  fun copyConInfo context {path: path, ty: ty, id: ConID.id} =
      {path=path, ty=copyTy context ty, id=id}
  fun copyExnInfo context {path: path, ty: ty, id: ExnID.id} =
      {path=path, ty=copyTy context ty, id=id}
  fun copyExExnInfo context {path: path, ty: ty} =
      {path=path, ty=copyTy context ty}
  fun copyExnCon context exnCon =
      case exnCon of
        RC.EXEXN exExnInfo => RC.EXEXN (copyExExnInfo context exExnInfo)
      | RC.EXN exnInfo => RC.EXN (copyExnInfo context exnInfo)
  fun copyFfiTy context ffiTy =
      case ffiTy of
        TC.FFIBASETY (ty, loc) =>
        TC.FFIBASETY (copyTy context ty, loc)
      | TC.FFIFUNTY (attribOpt (* FFIAttributes.attributes option *),
                     ffiTyList1,
                     ffiTyList2,
                     ffiTyList3,loc) =>
        TC.FFIFUNTY (attribOpt,
                     map (copyFfiTy context) ffiTyList1,
                     Option.map (map (copyFfiTy context)) ffiTyList2,
                     map (copyFfiTy context) ffiTyList3,
                     loc)
      | TC.FFIRECORDTY (fields:(RecordLabel.label * TC.ffiTy) list,loc) =>
        TC.FFIRECORDTY
          (map (fn (l,ty)=>(l, copyFfiTy context ty)) fields,loc)

  val emptyVarIdMap = VarID.Map.empty : VarID.id VarID.Map.map
  val varIdMapRef = ref emptyVarIdMap : (VarID.id VarID.Map.map) ref
  fun addSubst (oldId, newId) = varIdMapRef := VarID.Map.insert(!varIdMapRef, oldId, newId)

  type varInfo = {path:path, id:VarID.id, ty:ty}
  (* alpha-rename terms *)
  fun newId ({varMap, btvMap, catchMap}:context) id =
      let
        val newId = VarID.generate()
        val _ = addSubst (id, newId)
        val varMap =
            VarID.Map.insertWith
              (fn _ => raise DuplicateVar)
              (varMap, id, newId)
      in
        ({varMap=varMap, btvMap=btvMap, catchMap=catchMap}, newId)
      end
  fun newVar (context:context) ({path, id, ty}:varInfo) =
      let
        val ty = copyTy context ty
        val (context, newId) =
            newId context id
            handle DuplicateVar =>
                   (P.printPath path;
                    P.print "\n";
                    raise bug "duplicate id in IDCalcUtils"
                   )
      in
        (context, {path=path, id=newId, ty=ty})
      end
  fun newVars (context:context) (vars:varInfo list) =
      let
        val (context, varsRev) =
            foldl
            (fn (var, (context, varsRev)) =>
                let
                  val (context, var) = newVar context var
                in
                  (context, var::varsRev)
                end
            )
            (context, nil)
            vars
      in
        (context, List.rev varsRev)
      end
  fun newCatch ({varMap, btvMap, catchMap}:context) label =
      let
        val newId = FunLocalLabel.derive label
        val catchMap = FunLocalLabel.Map.insert (catchMap, label, newId)
      in
        ({varMap=varMap, btvMap=btvMap, catchMap=catchMap}, newId)
      end

  fun evalVar (context as {varMap, ...}:context) ({path, id, ty}:varInfo) =
      let
        val ty = copyTy context ty
        val id =
            case VarID.Map.find(varMap, id) of
              SOME id => id
            | NONE => id
      in
        {path=path, id=id, ty=ty}
      end
      handle DuplicateBtv =>
             (P.print "DuplicateBtv in evalVar\n";
              P.printPath path;
              P.print "\n";
              P.printTy ty;
              P.print "\n";
              raise bug "DuplicateBtv in evalVar")
  fun copyExp (context:context) (exp:RC.rcexp) =
      let
        fun copy exp = copyExp context exp
        fun copyT ty = copyTy context ty
      in
        (
        case exp of
          RC.RCAPPM {argExpList, funExp, funTy, loc} =>
          RC.RCAPPM {argExpList = map copy argExpList,
                     funExp = copy funExp,
                     funTy = copyT funTy,
                     loc = loc}
        | RC.RCCASE  {defaultExp:rcexp, exp:rcexp, expTy:Types.ty, loc:Loc.loc,
                      ruleList:(RC.conInfo * varInfo option * rcexp) list,
                      resultTy} =>
          RC.RCCASE  {defaultExp=copy defaultExp, 
                      exp=copy exp, 
                      expTy=copyT expTy, 
                      loc=loc,
                      ruleList = 
                      map (fn (con, varOpt, exp) =>
                              let
                                val (newContext, varOpt) =
                                    case varOpt of
                                      NONE => (context, NONE)
                                    | SOME var => 
                                      let
                                        val (newContext, var) = 
                                            newVar context var
                                      in
                                        (newContext, SOME var)
                                      end
                              in
                                (copyConInfo context con,
                                 varOpt,
                                 copyExp newContext exp)
                              end
                          ) ruleList,
                      resultTy=resultTy
                     }
        | RC.RCCAST ((tpexp, expTy), ty, loc) =>
          RC.RCCAST ((copy tpexp, copyT expTy), copyT ty, loc)
        | RC.RCCONSTANT {const, loc, ty} =>
          RC.RCCONSTANT {const=const, loc = loc, ty=copyT ty}
        | RC.RCDATACONSTRUCT {argExpOpt, con:RC.conInfo, instTyList, loc} =>
          RC.RCDATACONSTRUCT
            {argExpOpt = Option.map copy argExpOpt,
             con = copyConInfo context con,
             instTyList = Option.map (map copyT) instTyList,
             loc = loc
            }
        | RC.RCEXNCASE {defaultExp:rcexp, exp:rcexp, expTy:ty, loc:Loc.loc,
                        ruleList:(RC.exnCon * varInfo option * rcexp) list,
                        resultTy} =>
          RC.RCEXNCASE {defaultExp=copy defaultExp, 
                        exp=copy exp,
                        expTy=copyT expTy, 
                        loc=loc,
                        ruleList = 
                        map (fn (con, varOpt, exp) =>
                                (copyExnCon context con,
                                 Option.map (evalVar context) varOpt,
                                 copy exp)
                            ) ruleList,
                        resultTy=resultTy
                       }
        | RC.RCEXNCONSTRUCT {argExpOpt, exn:RC.exnCon, loc} =>
          RC.RCEXNCONSTRUCT
            {argExpOpt = Option.map copy argExpOpt,
             exn = copyExnCon context exn,
             loc = loc
            }
        | RC.RCEXNTAG {exnInfo, loc} =>
          RC.RCEXNTAG {exnInfo=copyExnInfo context exnInfo , loc=loc}
        | RC.RCEXEXNTAG {exExnInfo, loc} =>
          RC.RCEXEXNTAG
            {exExnInfo=copyExExnInfo context exExnInfo,
             loc= loc}
        | RC.RCCALLBACKFN {attributes, resultTy, argVarList, bodyExp:rcexp,
                           loc:Loc.loc} =>
          let
            val resultTy = Option.map (copyTy context) resultTy
            val (context, argVarList) = newVars context argVarList
            val bodyExp = copyExp context bodyExp
          in
            RC.RCCALLBACKFN
              {attributes = attributes,
               resultTy = resultTy,
               argVarList = argVarList,
               bodyExp = bodyExp,
               loc = loc}
          end
        | RC.RCEXVAR exVar =>
          RC.RCEXVAR (copyExVarInfo context exVar)
        | RC.RCFFI (rcffiexp, ty, loc) =>
          RC.RCFFI (copyRcffiexp context rcffiexp, 
                    copyT ty, 
                    loc)
        | RC.RCFNM {argVarList, bodyExp, bodyTy, loc} =>
          let
            val bodyTy = copyT bodyTy
            val (context, argVarList) = newVars context argVarList
            val bodyExp = copyExp context bodyExp
          in
            RC.RCFNM
              {argVarList = argVarList,
               bodyExp = bodyExp,
               bodyTy = bodyTy,
               loc = loc}
          end
        | RC.RCFOREIGNAPPLY {argExpList:rcexp list,
                             attributes, resultTy, funExp:rcexp,
                             loc:Loc.loc} =>
          RC.RCFOREIGNAPPLY
            {argExpList = map copy argExpList,
             attributes = attributes,
             funExp=copy funExp,
             resultTy = resultTy,
             loc=loc}
        | RC.RCFOREIGNSYMBOL {loc, name, ty} =>
          RC.RCFOREIGNSYMBOL {loc=loc, name=name, ty=copyT ty}
        | RC.RCHANDLE {exnVar, exp, handler, resultTy, loc} =>
          let
            val (context, exnVar) = newVar context exnVar
          in
            RC.RCHANDLE 
              {exnVar=exnVar, 
               exp=copy exp, 
               handler=copyExp context handler, 
               resultTy= copyT resultTy,
               loc=loc}
          end
        | RC.RCCATCH {catchLabel, argVarList, catchExp, tryExp, resultTy,
                      loc} =>
          let
            val (context, argVarList) = newVars context argVarList
            val (context2, catchLabel) = newCatch context catchLabel
          in
            RC.RCCATCH
              {catchLabel = catchLabel,
               argVarList = argVarList,
               catchExp = copyExp context catchExp,
               tryExp = copyExp context2 tryExp,
               resultTy = copyT resultTy,
               loc = loc}
          end
        | RC.RCTHROW {catchLabel, argExpList, resultTy, loc} =>
          RC.RCTHROW
            {catchLabel =
               case FunLocalLabel.Map.find (#catchMap context, catchLabel) of
                 SOME label => label
               | NONE => catchLabel,
             argExpList = map (copyExp context) argExpList,
             resultTy = copyT resultTy,
             loc = loc}
        | RC.RCINDEXOF (string, ty, loc) =>
          RC.RCINDEXOF (string, copyT ty, loc)
        | RC.RCLET {body, decls, loc} =>
          let
            val (context, decls) = copyDeclList context decls
          in
            RC.RCLET {body=copyExp context body,
                      decls=decls,
                      loc=loc}
          end
        | RC.RCMODIFY {elementExp, elementTy, indexExp, label, loc, recordExp, recordTy} =>
          RC.RCMODIFY
            {elementExp = copy elementExp,
             elementTy = copyT elementTy,
             indexExp = copy indexExp,
             label = label,
             loc = loc,
             recordExp = copy recordExp,
             recordTy = copyT recordTy}
        | RC.RCOPRIMAPPLY {argExp, instTyList, loc, oprimOp:RC.oprimInfo} =>
          RC.RCOPRIMAPPLY
            {argExp = copy argExp,
             instTyList = map copyT instTyList,
             loc = loc,
             oprimOp = copyOprimInfo context oprimOp
            }
        | RC.RCPOLY {btvEnv, exp, expTyWithoutTAbs, loc} =>
          (
          let
            val (context, btvEnv) = newBtvEnv context btvEnv
          in
            RC.RCPOLY
              {btvEnv=btvEnv,
               exp = copyExp context exp,
               expTyWithoutTAbs = copyTy context expTyWithoutTAbs,
               loc = loc
              }
          end
          handle DuplicateBtv =>
                raise DuplicateBtv
          )

        | RC.RCPRIMAPPLY {argExp, instTyList, loc, primOp:T.primInfo} =>
          RC.RCPRIMAPPLY
            {argExp = copy argExp,
             instTyList = Option.map (map copyT) instTyList,
             loc = loc,
             primOp = copyPrimInfo context primOp
            }
        | RC.RCRAISE {exp, loc, ty} =>
          RC.RCRAISE {exp= copy exp, loc=loc, ty = copyT ty}
        | RC.RCRECORD {fields:rcexp RecordLabel.Map.map, loc, recordTy} =>
          RC.RCRECORD
            {fields=RecordLabel.Map.map copy fields,
             loc=loc,
             recordTy=copyT recordTy}
        | RC.RCSELECT {exp, expTy, indexExp, label, loc, resultTy} =>
          RC.RCSELECT
            {exp=copy exp,
             expTy=copyT expTy,
             indexExp=copy indexExp, 
             label=label,
             loc=loc,
             resultTy=copyT resultTy
            }
        | RC.RCSIZEOF (ty, loc) =>
          RC.RCSIZEOF (copyT ty, loc)
        | RC.RCREIFYTY (ty, loc) =>
          RC.RCREIFYTY (copyT ty, loc)
        | RC.RCSWITCH {branches:(RC.constant * rcexp) list, defaultExp:rcexp,
                       expTy:Types.ty, loc:Loc.loc, switchExp:rcexp,
                       resultTy} =>
          RC.RCSWITCH
            {branches = 
             map (fn (const, exp) => (const, copy exp)) branches, 
             defaultExp=copy defaultExp,
             expTy=copyT expTy, 
             loc=loc, 
             switchExp= copy switchExp,
             resultTy=resultTy}
        | RC.RCTAGOF (ty, loc) => RC.RCTAGOF (copyT ty, loc)
        | RC.RCTAPP {exp, expTy, instTyList, loc} =>
          RC.RCTAPP {exp=copy exp,
                     expTy = copyT expTy,
                     instTyList=map copyT instTyList,
                     loc = loc
                    }
        | RC.RCVAR varInfo =>
          RC.RCVAR (evalVar context varInfo)
        | RC.RCJOIN {isJoin, ty,args=(arg1,arg2),argTys=(argTy1,argTy2),loc} =>
          RC.RCJOIN {ty=copyT ty,
                     args=(copy arg1,copy arg2),
                     argTys=(copyT argTy1,copyT argTy2),
                     isJoin = isJoin,
                     loc=loc}
        | RC.RCDYNAMIC {exp,ty,elemTy, coerceTy,loc} =>
          RC.RCDYNAMIC {exp=copy exp,
                        ty=copyT ty,
                        elemTy = copyT elemTy,
                        coerceTy=copyT coerceTy,
                        loc=loc}
        | RC.RCDYNAMICIS {exp,ty,elemTy, coerceTy,loc} =>
          RC.RCDYNAMICIS {exp=copy exp,
                          ty=copyT ty,
                          elemTy = copyT elemTy,
                          coerceTy=copyT coerceTy,
                          loc=loc}
        | RC.RCDYNAMICNULL {ty, coerceTy,loc} =>
          RC.RCDYNAMICNULL {ty=copyT ty,
                            coerceTy=copyT coerceTy,
                            loc=loc}
        | RC.RCDYNAMICTOP {ty, coerceTy,loc} =>
          RC.RCDYNAMICTOP {ty=copyT ty,
                            coerceTy=copyT coerceTy,
                            loc=loc}
        | RC.RCDYNAMICVIEW {exp,ty,elemTy, coerceTy,loc} =>
          RC.RCDYNAMICVIEW {exp=copy exp,
                            ty=copyT ty,
                            elemTy = copyT elemTy,
                            coerceTy=copyT coerceTy,
                            loc=loc}
        | RC.RCDYNAMICCASE
         {
          groupListTerm, 
          groupListTy, 
          dynamicTerm, 
          dynamicTy, 
          elemTy, 
          ruleBodyTy, 
          loc} =>
          RC.RCDYNAMICCASE
            {
             groupListTerm  = copy groupListTerm, 
             groupListTy = copyT groupListTy,
             dynamicTerm = copy dynamicTerm,
             dynamicTy = copyT dynamicTy,
             elemTy = copyT elemTy, 
             ruleBodyTy = copyT ruleBodyTy, 
             loc=loc
            }
        | RC.RCDYNAMICEXISTTAPP {existInstMap, exp, expTy, instTyList, loc} =>
          RC.RCDYNAMICEXISTTAPP
            {existInstMap = copy existInstMap,
             exp = copy exp,
             expTy = copyT expTy,
             instTyList = map copyT instTyList,
             loc = loc}
        )
          handle DuplicateBtv =>
                 raise bug "DuplicateBtv in copyExp copyExp"
    end
  and copyBranch context (constant,rcexp) =
      (constant, copyExp context rcexp)
   
  and copyRcffiexp context (RC.RCFFIIMPORT {ffiTy:TypedCalc.ffiTy, funExp}) =
      RC.RCFFIIMPORT
        {ffiTy = copyFfiTy context ffiTy,
         funExp= case funExp of
                   RC.RCFFIFUN (exp, ty) => RC.RCFFIFUN (copyExp context exp, copyTy context ty)
                 | RC.RCFFIEXTERN _ => funExp}
  and copyDecl context tpdecl =
      case tpdecl of
        RC.RCEXD (exnInfo, loc) =>
        (context,
         RC.RCEXD
           (copyExnInfo context exnInfo,
            loc)
        )
      | RC.RCEXNTAGD ({exnInfo, varInfo}, loc) =>
        (context,
         RC.RCEXNTAGD ({exnInfo=copyExnInfo context exnInfo,
                        varInfo=evalVar context varInfo},
                       loc)
        )
      | RC.RCEXPORTEXN exnInfo =>
        (context,
         RC.RCEXPORTEXN (copyExnInfo context exnInfo)
        )
      | RC.RCEXPORTVAR {var={path,ty}, exp} =>
        (context,
         RC.RCEXPORTVAR {var = {path = path, ty = copyTy context ty},
                         exp = copyExp context exp}
        )
      | RC.RCEXTERNEXN ({path, ty}, provider) =>
        (context,
         RC.RCEXTERNEXN ({path=path, ty=copyTy context ty}, provider)
        )
      | RC.RCBUILTINEXN {path, ty} =>
        (context,
         RC.RCBUILTINEXN {path=path, ty=copyTy context ty}
        )
      | RC.RCEXTERNVAR ({path, ty}, provider) =>
        (context,
         RC.RCEXTERNVAR ({path=path, ty=copyTy context ty}, provider)
        )
      | RC.RCVAL (bind:(varInfo * rcexp), loc) =>
        let
          val (context, bind) = copyBind (context, context) bind
        in
          (context, RC.RCVAL (bind, loc))
        end
      | RC.RCVALPOLYREC
          (btvEnv,
           recbinds:{exp:rcexp, var:varInfo} list,
           loc) =>
        (
        let
          val (newContext, btvEnv) = newBtvEnv context btvEnv
          val vars = map #var recbinds
          val (newContext as {varMap, ...}, vars) = newVars newContext vars
          val varRecbindList = ListPair.zip (vars, recbinds)
          val recbinds =
              map
                (fn (var, {exp, var=_}) =>
                    {var=var,
                     exp=copyExp newContext exp}
                )
                varRecbindList
        in
          ({varMap=varMap, btvMap = #btvMap context, catchMap = #catchMap context},
           RC.RCVALPOLYREC (btvEnv, recbinds, loc))
        end
          handle DuplicateBtv =>
                raise bug "TPVALPOLYREC"
        )
      | RC.RCVALREC (recbinds:{exp:rcexp, var:varInfo} list,loc) =>
        let
          val vars = map #var recbinds
          val (context, vars) = newVars context vars
          val varRecbindList = ListPair.zip (vars, recbinds)
          val recbinds =
              map
                (fn (var, {exp, var=_}) =>
                    {var=var,
                     exp=copyExp context exp}
                )
                varRecbindList
        in
          (context, RC.RCVALREC (recbinds, loc))
        end
  and copyBind (newContext, context) (var, exp) =
      let
        val (newContext, var) = newVar newContext var
        val exp = copyExp newContext exp
      in
        (newContext, (var, exp))
      end
  and copyBinds context binds =
      let
        val (newContext, bindsRev) =
            foldl
            (fn (bind, (newContext, bindsRev)) =>
                let
                  val (newContext, bind) = copyBind (newContext, context) bind
                in
                  (newContext, bind::bindsRev)
                end
            )
            (context, nil)
            binds
      in
        (newContext, List.rev bindsRev)
      end
  and copyDeclList context declList =
      let
        fun copy (decl, (context, declListRev)) =
            let
              val (context, newDecl) = copyDecl context decl
            in
              (context, newDecl::declListRev)
            end
        val (context, declListRev) = foldl copy (context, nil) declList
      in
        (context, List.rev declListRev)
      end
in
  val copyExp = 
   fn exp => 
      let
        val _ = varIdMapRef := emptyVarIdMap
        val exp = copyExp emptyContext exp
      in
        (!varIdMapRef, exp)
      end
      handle exn => 
             (P.print "RCAlphaRename; exception\n";
              printRcexp exp;
              P.print "\n";
              raise exn)
end
end
