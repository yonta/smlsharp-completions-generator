(**
 * @copyright (C) 2021 SML# Development Team.
 * @author Atsushi Ohori
 *)
structure UncurryFundecl : UNCURRYFUNDECL = struct
local

  structure T = Types
  structure TB = TypesBasics
  (* structure TIU = TypeInferenceUtils *)
  structure TC = TypedCalc
  structure TCU = TypedCalcUtils

  fun makeVar loc ty = TCU.newTCVarInfo loc ty

  fun grabTy (ty, arity) =
    let
      fun grab 0 ty tyList = (tyList, ty)
        | grab n ty tyList = 
            (case TB.derefTy ty of
               (T.FUNMty([domty], ranty)) =>
                 grab (n - 1) ranty (tyList@[domty])
              | _ => 
                 (
                  print (Bug.prettyPrint (T.format_ty ty));
                  raise Bug.Bug "grabTy"
                  )
             )
    in
      grab arity ty nil
    end

  fun grabAndApply (funbody, argTyList, bodyTy, spine, loc) = 
    (*
     * funbody should be a fun id whose type has already been 
     * converted to uncurried one.
     * spine : (A,a -> b -> c -> d)::(B,b -> c -> d)::(C,c -> d)
     * funBody this should be of type  (a -> b -> c -> d)
     *)
    let
      fun take 0 L = (nil, L)
        | take n (h::t) = 
          let
            val (L1, L2) = take (n - 1) t 
          in
            (h::L1, L2) 
          end
        | take n nil =
          raise
            Bug.Bug
              "take from nil (typeinference/main/UncurryFundecl.sml)"
      val existingArgNum = length spine
      val arity = length argTyList
    in
      if arity > existingArgNum then
        let
          val newVars = map (makeVar loc) (List.drop (argTyList, existingArgNum))
        in
          #2
          (foldr 
           (fn (var as {ty,...}, (bodyTy, bodyExp)) => 
            (T.FUNMty([ty], bodyTy),
             TC.TPFNM {argVarList = [var],
                       bodyTy = bodyTy,
                       bodyExp = bodyExp,
                       loc = loc}
            )
            )
           (bodyTy,
            TC.TPAPPM
              {funExp =funbody, 
               funTy = T.FUNMty (argTyList, bodyTy),
               argExpList =
                 (map #1 spine @ (map TC.TPVAR newVars)), 
               loc = loc}
            )
           newVars
           )
        end
      else
        let
          val (argsToFun, remainingArgs) = take arity spine
        in
           foldl 
            (fn ((exp, funty), funbody) => 
                 TC.TPAPPM{funExp = funbody, 
                           funTy = funty,
                           argExpList = [exp],
                           loc = loc}
            )
            (case argsToFun of
                 nil => funbody
               | _ => 
                   TC.TPAPPM 
                   {funExp = funbody, 
                    funTy = T.FUNMty (argTyList, bodyTy),
                    argExpList = map #1 argsToFun,
                    loc=loc})
            remainingArgs
        end
    end

  fun makeApply  (funbody, spine, loc) = 
      foldl 
       (fn ((exp, funty), funbody) => 
           TC.TPAPPM{funExp=funbody, funTy=funty, argExpList=[exp],loc=loc}
        )
       funbody
       spine
in

  fun matchToFnCaseTerm  loc {ruleList = nil,...} =
      raise
        Bug.Bug
          "empty rule in matchToFnCaseTerm\
          \(typeinference/main/UncurryFundecl.sml)"
    | matchToFnCaseTerm  
        loc
        {
         funVarInfo as {opaque, path=funLongsymbol,id=funId,...}, 
         argTyList, 
         bodyTy, 
         ruleList = ruleList as _::_
        }
      =
      let
        val (newVars, newPats) = 
            foldr 
              (fn (ty, (newVars, newPats)) => 
                  let 
                    val varInfo = makeVar loc ty
                  in
                    (
                     varInfo::newVars,
                     TC.TPPATVAR varInfo :: newPats
                    )
                  end
              )
              (nil,nil)
              argTyList
        val newTy = T.FUNMty(argTyList, bodyTy)
      in
        ({path=funLongsymbol, id=funId, ty =newTy, opaque=false},
         TC.TPFNM {argVarList = newVars,
                   bodyTy = bodyTy,
                   loc = loc,
                   bodyExp =
                   TC.TPCASEM
                     {expList = map TC.TPVAR newVars,
                      expTyList = argTyList,
                      ruleList = 
                        map 
                        (fn {args,body}=>{args=args,body=uncurryExp  nil body})
                        ruleList,
                      ruleBodyTy = bodyTy,
                      caseKind = PatternCalc.MATCH,
                      loc = loc}
                  }
        )
      end

  and uncurryExp spine tpexp = 
    case tpexp of
      TC.TPERROR => tpexp
    | TC.TPCONSTANT {const, ty, loc} => makeApply(tpexp, spine, loc)
    | TC.TPVAR {path,...} => makeApply (tpexp, spine, Symbol.longsymbolToLoc path)
    | TC.TPEXVAR ({path,...},loc) => makeApply (tpexp, spine, Symbol.longsymbolToLoc path)
    | 
      (*
       * grab the arity amount of argument from the spine stack and make 
       * an uncurried application.
       * If the spine does not contain enough arguments, then we perfrom 
       * eta-expansion.
       * If the size of the spine is larger than arity then 
       * we re-construct applications, i.e. uncurrying is performed 
       * only for statically know function indicated by TC.TPRECFUNVAR.
       *)
      TC.TPRECFUNVAR {var={path, id, ty, opaque}, arity} =>
      (
       case (TB.derefTy ty, spine) of
         (polyty as T.POLYty {boundtvars, constraints, body}, nil) =>
          (* this should be the case 
               val f = f 
             where f is an uncurried polymorphic function.
             In this case we do 
                typeinstantiation
                make a nested fun
                type generalization
          *)
          let
            val loc = Symbol.longsymbolToLoc path
            val (subst, boundtvars) = 
                TB.copyBoundEnv boundtvars
            val body = TB.substBTvar subst body
            val (argTyList, newBodyTy) = grabTy (body, arity)
            val uncurriedTy =
                TyAlphaRename.copyTy
                  TyAlphaRename.emptyBtvMap
                  (T.POLYty {boundtvars = boundtvars,
                             constraints = constraints,
                             body = T.FUNMty (argTyList, newBodyTy)})
            val curriedTyBody =
                foldr (fn (ty, bodyTy) => T.FUNMty ([ty], bodyTy))
                      newBodyTy
                      argTyList
            val curriedTy =
                T.POLYty {boundtvars = boundtvars,
                          constraints = constraints,
                          body = curriedTyBody}
            val newPolyTtermBody =
                grabAndApply 
                  (TC.TPTAPP
                     {exp = TC.TPVAR {path=path, id=id, ty=uncurriedTy, opaque=false},
                      expTy = uncurriedTy,
                      instTyList =
                      map
                        T.BOUNDVARty
                        (BoundTypeVarID.Map.listKeys boundtvars),
                      loc = loc},
                   argTyList, 
                   newBodyTy,
                   spine, 
                   loc)
          in
            TC.TPPOLY{btvEnv = boundtvars,
                      constraints = constraints,
                      expTyWithoutTAbs = curriedTyBody,
                      exp = newPolyTtermBody,
                      loc = loc
                     }
          end
       | (T.POLYty {boundtvars, constraints, body}, x::_) =>
         raise Bug.Bug "polymorphic uncurried function with non nil spine"
       | _ => 
         (
          let
            val loc = Symbol.longsymbolToLoc path
            val (argTyList, bodyTy) = grabTy (ty, arity)
          in
            grabAndApply 
              (TC.TPVAR
                 {path=path, id=id, ty= T.FUNMty(argTyList, bodyTy), opaque=false}, 
               argTyList, 
               bodyTy,
               spine, 
               loc)
          end
          handle x => raise x
         )
      )
    | TC.TPFNM {argVarList, bodyTy, bodyExp, loc} =>
      let
        val newBodyExp = uncurryExp  nil bodyExp
      in
        makeApply(TC.TPFNM {argVarList = argVarList, 
                            bodyTy = bodyTy, 
                            bodyExp = newBodyExp, 
                            loc = loc},
                  spine,
                  loc)
      end
    | TC.TPAPPM {funExp, funTy, argExpList = [argExp], loc} =>
        let
          val newArgExp = uncurryExp nil argExp
        in
          uncurryExp ((newArgExp, funTy)::spine) funExp
        end
    | 
      (*
       * We only uncurry single argument functions.
       * This case should not happen for the current system, 
       * but in future we may allow uncurried user functions.
       *)
      TC.TPAPPM {funExp, funTy, argExpList, loc} =>
      let
        val newFunExp = uncurryExp nil funExp
        val newArgExpList = map (uncurryExp nil) argExpList
      in
        makeApply (TC.TPAPPM{funExp = newFunExp, 
                             funTy = funTy, 
                             argExpList = newArgExpList, 
                             loc = loc},
                   spine,
                   loc)
      end
    | TC.TPDATACONSTRUCT {con, instTyList, argExpOpt = SOME exp, loc} =>
      let
        val newTpexp = TC.TPDATACONSTRUCT
                         {con=con, 
                          instTyList=instTyList, 
                          argExpOpt = SOME (uncurryExp nil exp), 
                          loc = loc}
      in
        makeApply (newTpexp, spine, loc)
      end
    | TC.TPDATACONSTRUCT {con, instTyList, argExpOpt = NONE, loc} =>
      makeApply (tpexp, spine, loc)
    | TC.TPEXNCONSTRUCT {exn, argExpOpt = SOME exp, loc} =>
      let
        val newTpexp = TC.TPEXNCONSTRUCT
                         {exn=exn, 
                          argExpOpt = SOME (uncurryExp nil exp), 
                          loc = loc}
      in
         makeApply (newTpexp, spine, loc)
      end
    | TC.TPEXNCONSTRUCT {exn, argExpOpt = NONE, loc} =>
      makeApply (tpexp, spine, loc)
    | TC.TPEXNTAG {exnInfo, loc} =>
      makeApply (tpexp, spine, loc)
    | TC.TPEXEXNTAG {exExnInfo, loc} =>
      makeApply (tpexp, spine, loc)
    | TC.TPCASEM {expList, expTyList, ruleList, ruleBodyTy, caseKind, loc} =>
      let
        val newExpList = map (uncurryExp  nil) expList
        val newRuleList =
            map
              (fn {args, body} => {args=args, body= uncurryExp  nil body})
              ruleList
      in
        makeApply(TC.TPCASEM {expList = newExpList, 
                              expTyList = expTyList, 
                              ruleList = newRuleList, 
                              ruleBodyTy = ruleBodyTy,
                              caseKind = caseKind,
                              loc = loc},
                  spine,
                  loc)
      end
    | TC.TPSWITCH {exp, expTy, ruleList, defaultExp, ruleBodyTy, loc} =>
      let
        fun uncurryBody (r as {body, ...}) = r # {body = uncurryExp nil body}
      in
        makeApply
          (TC.TPSWITCH
             {exp = uncurryExp nil exp,
              expTy = expTy,
              ruleList =
                case ruleList of
                  TC.CONSTCASE rules => TC.CONSTCASE (map uncurryBody rules)
                | TC.CONCASE rules => TC.CONCASE (map uncurryBody rules)
                | TC.EXNCASE rules => TC.EXNCASE (map uncurryBody rules),
              defaultExp = uncurryExp nil defaultExp,
              ruleBodyTy = ruleBodyTy,
              loc = loc},
           spine, loc)
      end
    | TC.TPCATCH {catchLabel, tryExp, argVarList, catchExp, resultTy, loc} =>
      makeApply
        (TC.TPCATCH
           {catchLabel = catchLabel,
            tryExp = uncurryExp nil tryExp,
            argVarList = argVarList,
            catchExp = uncurryExp nil catchExp,
            resultTy = resultTy,
            loc = loc},
         spine, loc)
    | TC.TPTHROW {catchLabel, argExpList, resultTy, loc} =>
      makeApply
        (TC.TPTHROW
           {catchLabel = catchLabel,
            argExpList = map (uncurryExp nil) argExpList,
            resultTy = resultTy,
            loc = loc},
         spine, loc)
    | TC.TPPRIMAPPLY {primOp, instTyList, argExp = exp, loc} =>
      let
        val newTpexp = TC.TPPRIMAPPLY {primOp=primOp, 
                                       instTyList=instTyList, 
                                       argExp = uncurryExp nil exp, 
                                       loc = loc}
       in
        makeApply (newTpexp, spine, loc)
      end
    | TC.TPOPRIMAPPLY {oprimOp, instTyList, argExp = exp, loc} =>
      let
        val newTpexp = TC.TPOPRIMAPPLY {oprimOp = oprimOp,
                                        instTyList = instTyList, 
                                        argExp = uncurryExp nil exp, 
                                        loc = loc}
      in
        makeApply (newTpexp, spine, loc)
      end
    | TC.TPRECORD {fields, recordTy, loc} =>
      let
        val newFields = RecordLabel.Map.map (uncurryExp  nil) fields
      in
        makeApply
          (TC.TPRECORD {fields = newFields, recordTy = recordTy, loc=loc},
           spine,
           loc)
      end
    | TC.TPSELECT {label, exp, expTy, resultTy, loc} =>
      let
        val newExp = uncurryExp  nil exp
      in
        makeApply(TC.TPSELECT {label = label, 
                               exp = newExp, 
                               expTy = expTy, 
                               resultTy = resultTy,
                               loc = loc},
                  spine,
                  loc)
      end
    | TC.TPMODIFY {label, recordExp, recordTy, elementExp, elementTy, loc} =>
      let
        val newRecordExp = uncurryExp  nil recordExp
        val newElementExp = uncurryExp  nil elementExp
      in
        makeApply(TC.TPMODIFY {label = label, 
                               recordExp = newRecordExp, 
                               recordTy = recordTy, 
                               elementExp = newElementExp,
                               elementTy = elementTy,
                               loc = loc},
                  spine,
                  loc)
      end
    | TC.TPMONOLET {binds, bodyExp, loc} =>
      let
        val newBinds = map (fn (v,exp) => (v, uncurryExp  nil exp))binds
        val newBodyExp = uncurryExp  nil bodyExp
      in
        makeApply(TC.TPMONOLET {binds=newBinds, bodyExp=newBodyExp, loc=loc},
                  spine,
                  loc)
      end
    | TC.TPLET {decls, body, loc} =>
      let
        val decls = uncurryDeclList decls
        val body = uncurryExp  nil body
      in
        makeApply(TC.TPLET {decls=decls, body=body, loc=loc},
                  spine,
                  loc)
      end
    | TC.TPRAISE {exp,ty,loc} =>
      makeApply(TC.TPRAISE{exp=uncurryExp  nil exp,ty=ty,loc=loc},
                spine,
                loc)
    | TC.TPHANDLE {exp, exnVar, handler, resultTy, loc} =>
      let
        val newExp = uncurryExp  nil exp
        val newHandler = uncurryExp  nil handler
      in
        makeApply(TC.TPHANDLE {exp = newExp, 
                               exnVar = exnVar, 
                               handler = newHandler, 
                               resultTy = resultTy,
                               loc = loc},
                  spine,
                  loc)
      end
    | TC.TPPOLY {btvEnv, constraints, expTyWithoutTAbs, exp, loc} =>
      let
        val newExp = uncurryExp  nil exp
      in
        makeApply(TC.TPPOLY {btvEnv=btvEnv, 
                             constraints=constraints,
                             expTyWithoutTAbs = expTyWithoutTAbs, 
                             exp = newExp, 
                             loc = loc},
                  spine,
                  loc)
      end
    | TC.TPTAPP
        {exp = TC.TPRECFUNVAR {var={path, id, ty,  opaque}, arity},
         expTy,
         instTyList,
         loc=loc2} =>
      (
       let
         val instTy = TB.tpappTy(expTy, instTyList)
         val (argTyList, bodyTy) = grabTy (instTy, arity)
         val newPolyTy =
             case TB.derefTy ty of 
               T.POLYty{boundtvars, constraints, body} =>
               T.POLYty{boundtvars = boundtvars,
                        constraints = constraints, 
                        body = T.FUNMty(grabTy(body, arity))}
             | _ => raise Bug.Bug "non function type in TC.TPRECFUNVAR"
       in
         grabAndApply 
           (TC.TPTAPP
              {exp = TC.TPVAR {path=path, id=id, ty=newPolyTy,  opaque=opaque}, 
               expTy=newPolyTy, 
               instTyList=instTyList, 
               loc=loc2},
            argTyList, 
            bodyTy,
            spine, 
            loc2)
       end
       handle x => raise x
      )
    | TC.TPTAPP {exp, expTy, instTyList, loc} =>
      let
        val newExp = uncurryExp  nil exp
      in
        makeApply(TC.TPTAPP {exp=newExp, 
                             expTy = expTy, 
                             instTyList = instTyList, 
                             loc = loc},
                  spine,
                  loc)
      end
    | TC.TPFFIIMPORT {funExp, ffiTy, stubTy, loc} =>
      makeApply
        (TC.TPFFIIMPORT
           {funExp =
              case funExp of
                TC.TPFFIFUN (ptrExp, ty) => TC.TPFFIFUN (uncurryExp nil ptrExp, ty)
              | TC.TPFFIEXTERN _ => funExp,
            ffiTy = ffiTy,
            stubTy = stubTy,
            loc = loc},
         spine, loc)
    | TC.TPFOREIGNSYMBOL {name, ty, loc} => makeApply (tpexp, spine, loc)
    | TC.TPFOREIGNAPPLY {funExp, argExpList, attributes, resultTy, loc} =>
      makeApply
        (TC.TPFOREIGNAPPLY
           {funExp = uncurryExp nil funExp,
            argExpList = map (uncurryExp nil) argExpList,
            attributes = attributes,
            resultTy = resultTy,
            loc = loc},
         spine, loc)
    | TC.TPCALLBACKFN {attributes, argVarList, bodyExp, resultTy, loc} =>
      makeApply
        (TC.TPCALLBACKFN
           {attributes = attributes,
            argVarList = argVarList,
            bodyExp = uncurryExp nil bodyExp,
            resultTy = resultTy,
            loc = loc},
         spine, loc)
    | TC.TPCAST ((tpexp, expTy), ty, loc) =>
      makeApply(TC.TPCAST((uncurryExp nil tpexp, expTy), ty, loc),
                spine,
                loc)
      
    | TC.TPSIZEOF (_,loc) => makeApply (tpexp, spine, loc)
    | TC.TPJOIN {isJoin, ty, args = (arg1, arg2), argtys, loc} =>
      makeApply (TC.TPJOIN {ty = ty,
                            args = (uncurryExp nil arg1, uncurryExp nil arg2),
                            argtys = argtys,
                            isJoin = isJoin,
                            loc = loc},
                 spine,
                 loc)
    | TC.TPREIFYTY (_,loc) => makeApply (tpexp, spine, loc)
    | TC.TPDYNAMIC {exp,ty,elemTy, coerceTy,loc} =>
      makeApply(TC.TPDYNAMIC {exp=uncurryExp nil exp,
                              ty=ty,
                              elemTy = elemTy,
                              coerceTy=coerceTy,
                              loc=loc},
                spine,
                loc)
    | TC.TPDYNAMICIS {exp,ty,elemTy, coerceTy,loc} =>
      makeApply(TC.TPDYNAMICIS {exp=uncurryExp nil exp,
                                ty=ty,
                                elemTy = elemTy,
                                coerceTy=coerceTy,
                                loc=loc},
                spine,
                loc)
    | TC.TPDYNAMICNULL {ty, coerceTy,loc} => makeApply(tpexp, spine, loc)
    | TC.TPDYNAMICTOP {ty, coerceTy,loc} => makeApply(tpexp, spine, loc)
    | TC.TPDYNAMICVIEW {exp,ty,elemTy, coerceTy,loc} =>
      makeApply(TC.TPDYNAMICVIEW {exp=uncurryExp nil exp,
                                  ty=ty,
                                  elemTy = elemTy,
                                  coerceTy=coerceTy,
                                  loc=loc},
                spine,
                loc)
    | TC.TPDYNAMICCASE 
        {groupListTerm, groupListTy, dynamicTerm, dynamicTy, elemTy, ruleBodyTy, loc} =>
      makeApply(TC.TPDYNAMICCASE
                  {
                   groupListTerm = uncurryExp nil groupListTerm,
                   groupListTy = groupListTy,
                   dynamicTerm = uncurryExp nil dynamicTerm,
                   dynamicTy = dynamicTy,
                   elemTy = elemTy,
                   ruleBodyTy = ruleBodyTy,
                   loc = loc},
                  spine,
                  loc)
    | TC.TPDYNAMICEXISTTAPP {existInstMap, exp, expTy, instTyList, loc} =>
      makeApply
        (TC.TPDYNAMICEXISTTAPP
           {existInstMap = uncurryExp nil existInstMap,
            exp = uncurryExp nil exp,
            expTy = expTy,
            instTyList = instTyList,
            loc = loc},
         spine,
         loc)

  and uncurryDecl tpdecl = 
      case tpdecl of
        TC.TPVAL ((id, exp), loc) =>
        [TC.TPVAL((id, uncurryExp  nil exp),
                  loc)]
      | TC.TPFUNDECL (fundecls, loc) =>
        [TC.TPVALREC
           (map (fn (var, exp) => {var=var,exp=exp})
                (map (matchToFnCaseTerm  loc) fundecls),
            loc)]
      | TC.TPPOLYFUNDECL {btvEnv, constraints, recbinds=fundecls, loc} =>
        [TC.TPVALPOLYREC
           {btvEnv=btvEnv, 
            constraints=constraints,
            recbinds=
            map (fn (var, exp) => {var=var,exp=exp})
                (map (matchToFnCaseTerm  loc) fundecls),
            loc=loc}]
      | TC.TPVALREC (bindList, loc) =>
        [TC.TPVALREC
           (map (fn {var, exp} =>
                    {var=var, exp=uncurryExp nil exp})
                bindList, loc)
        ]
      | TC.TPVALPOLYREC {btvEnv, constraints, recbinds=recBinds, loc} =>
        [
         TC.TPVALPOLYREC
           {btvEnv=btvEnv, 
            constraints=constraints,
            recbinds=
            map
              (fn {var, exp} =>
                  {var=var, exp = uncurryExp nil exp})
              recBinds, 
            loc=loc}
        ]
      | TC.TPEXD _ => [tpdecl]
      | TC.TPEXNTAGD _ => [tpdecl]
      | TC.TPEXTERNVAR  _ => [tpdecl]
      | TC.TPEXTERNEXN  _ => [tpdecl]
      | TC.TPBUILTINEXN  _ => [tpdecl]
      | TC.TPEXPORTEXN  _ => [tpdecl]
      | TC.TPEXPORTVAR {var, exp} =>
        [TC.TPEXPORTVAR {var = var, exp = uncurryExp nil exp}]

  and uncurryDeclList pldeclList = 
      foldr (fn (decl, declList) => (uncurryDecl decl) @ declList)
            nil
            pldeclList

  and optimize decList =  uncurryDeclList decList handle exn => raise exn

end
end

