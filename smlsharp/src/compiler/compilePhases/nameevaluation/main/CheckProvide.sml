(**
 * @copyright (C) 2021 SML# Development Team.
 * @author Atsushi Ohori
 *)
(* the initial error code of this file : CP-001 *)
structure CheckProvide =
struct
local
  structure I = IDCalc
  structure V = NameEvalEnv
  structure VP = NameEvalEnvPrims
  structure BT = BuiltinTypes
  structure PI = PatternCalcInterface
  structure PL = PatternCalc
  structure U = NameEvalUtils
  structure EU = UserErrorUtils
  structure E = NameEvalError
  structure A = AbsynInterface
  structure N = NormalizeTy
  structure Ty = EvalTy
  structure Sig = EvalSig
  structure FU = FunctorUtils
  structure EI = NameEvalInterface
  val nilPath = nil
  fun bug s = Bug.Bug ("CheckProvide: " ^ s)

  val symbolToLoc = Symbol.symbolToLoc
  val longsymbolToLoc = Symbol.longsymbolToLoc

  exception Fail
  fun raiseFail i = (U.print ( "CheckProvide Fail exception at " ^ (Int.toString i) ^ "\n"); raise Fail)
  val equalTyInterface = fn x => N.equalTyWithInterface true x
  val equalTy = fn x => N.equalTyWithInterface false x
  val equalTfunInterface = fn x => N.equalTfunWithInterface true x
  val equalTfun = fn x => N.equalTfunWithInterface false x

  fun isOpaque ty =
      let
        exception OPAQUE
        fun traverseTy ty =
            case ty of
              I.TYWILD => ()
            | I.TYERROR => ()
            | I.TYVAR _ => ()
            | I.TYFREE_TYVAR _ => ()
            | I.TYRECORD {ifFlex, fields} => RecordLabel.Map.app traverseTy fields
            | I.TYCONSTRUCT {tfun, args} =>
              (case tfun of
                 I.TFUN_VAR (ref (I.TFUN_DTY {dtyKind = I.OPAQUE _,...})) => raise OPAQUE 
               | _ => ();
               app traverseTy args)
            | I.TYFUNM (tyList, ty) => app traverseTy (ty::tyList)
            | I.TYPOLY (tvarlist, ty) => traverseTy ty
            | I.INFERREDTY typesTy => ()
      in
        (traverseTy ty; false) handle OPAQUE => true
      end

  fun isInterface ty =
      let
        exception OPAQUE
        fun traverseTy ty =
            case ty of
              I.TYWILD => ()
            | I.TYERROR => ()
            | I.TYVAR _ => ()
            | I.TYFREE_TYVAR _ => ()
            | I.TYRECORD {ifFlex, fields} => RecordLabel.Map.app traverseTy fields
            | I.TYCONSTRUCT {tfun, args} =>
              (case tfun of
                 I.TFUN_VAR (ref (I.TFUN_DTY {dtyKind = I.INTERFACE _,...})) => raise OPAQUE 
               | _ => ();
               app traverseTy args)
            | I.TYFUNM (tyList, ty) => app traverseTy (ty::tyList)
(*
            | I.TYPOLY (tvarlist, ty) => traverseTy ty
*)
            | I.TYPOLY (tvarlist, ty) => raise OPAQUE

            | I.INFERREDTY typesTy => ()
      in
        (traverseTy ty; false) handle OPAQUE => true
      end

  fun genTypedExportVarsIdstatus 
        exLongsymbol
        idstatus
        (exnSet, icdecls as {exportDecls, bindDecls}) =
      case idstatus of
        I.IDVAR {id=varId,...} => 
        (exnSet,
         {exportDecls=exportDecls @ 
                      [I.ICEXPORTTYPECHECKEDVAR
                         {longsymbol=exLongsymbol, version=I.SELF, id=varId}],
          bindDecls=nil}
        )
      | I.IDVAR_TYPED {id=varId,ty,...} => 
        (exnSet, 
         {exportDecls=exportDecls @ 
                      [I.ICEXPORTTYPECHECKEDVAR
                         {longsymbol=exLongsymbol, version=I.SELF, id=varId}],
          bindDecls=nil}
        )
      | I.IDEXVAR _ => (exnSet, icdecls)
      | I.IDEXVAR_TOBETYPED _ => raise bug "IDEXVAR_TOBETYPED"
      | I.IDBUILTINVAR _ => (exnSet, icdecls)
      | I.IDCON _ => (exnSet, icdecls)
      | I.IDEXN {id, ty,...} => 
        let
          val exInfo = {used = ref false, longsymbol=exLongsymbol, version=I.SELF, ty=ty}
        in
          if not (ExnID.Set.member(exnSet, id)) then
            (ExnID.Set.add(exnSet, id), 
             {exportDecls = 
              exportDecls @ [I.ICEXPORTEXN {exInfo=exInfo, id=id}],
              bindDecls=bindDecls}
            )
          else (exnSet, icdecls)
        end
      | I.IDEXNREP {id, ty,...} => 
        let
          val exInfo = {used = ref false, longsymbol=exLongsymbol, version=I.SELF, ty=ty}
        in
          if not (ExnID.Set.member(exnSet, id)) then
            (ExnID.Set.add(exnSet, id), 
             {exportDecls = 
              exportDecls @ [I.ICEXPORTEXN {exInfo=exInfo, id=id}],
              bindDecls=bindDecls}
            )
          else (exnSet, icdecls)
        end
      | I.IDEXEXN _ => (exnSet, icdecls)
      | I.IDEXEXNREP _ => (exnSet, icdecls)
      | I.IDOPRIM _ => (exnSet, icdecls)
      | I.IDSPECVAR _ => raise bug "IDSPECVAR in genTypedExportVars"
      | I.IDSPECEXN _ => raise bug "IDSPECEXN in genTypedExportVars"
      | I.IDSPECCON _ => raise bug "IDSPECCON in genTypedExportVars"

  fun genTypedExportVarsVarE path varE (exnSet,icdecls) =
      SymbolEnv.foldli
      (fn (name, idstatus, (exnSet, icdecls)) =>
          let
            val exLongsymbol = path@[name]
          in
            genTypedExportVarsIdstatus exLongsymbol idstatus (exnSet, icdecls)
          end
      )
      (exnSet, icdecls)
      varE
  fun genTypedExportVarsEnv path (V.ENV{varE, tyE, strE}) (exnSet,icdecls) =
      let
        val (exnSet, icdecls) = genTypedExportVarsVarE path varE (exnSet, icdecls)
        val (exnSet, icdecls) = genTypedExportVarsStrE path strE (exnSet, icdecls)
      in
        (exnSet, icdecls)
      end
  and genTypedExportVarsStrE path (V.STR strEntryMap) (exnSet,icdecls) =
      SymbolEnv.foldli
      (fn (name, {env, ...}, (exnSet,icdecls)) =>
          genTypedExportVarsEnv (path@[name]) env (exnSet,icdecls)
      )
      (exnSet, icdecls)
      strEntryMap

  fun checkDatbind
        path evalEnv env
        (name, defTstr, defRealTstr, defRealTfun, {tyvars, symbol=tycon, conbind, loc}, varE) 
    =
    (* datatype 'a foo = FOO of 'a | BAR  *)
    let
      val (tvarEnv, tvarList) = Ty.genTvarList Ty.emptyTvarEnv tyvars
    in
      let
        val {id, admitsEq, formals, conSpec, dtyKind,...} =
            case I.derefTfun defRealTfun of 
              I.TFUN_DEF _ =>
              (EU.enqueueError
                 (Symbol.symbolToLoc name,
                  E.ProvideDtyExpected ("CP-010",{longsymbol=path@[tycon]}));
               raiseFail 1)
            | I.TFUN_VAR(ref(I.TFUN_DTY x)) => x
            | _ =>
              (EU.enqueueError
                 (Symbol.symbolToLoc name,
                  E.ProvideDtyExpected ("CP-020",{longsymbol=path@[tycon]}));
               raiseFail 2)
        val eqEnv =
            if length tvarList = length formals then
              let
                val tvarPairs = ListPair.zip (tvarList, formals)
              in
                foldr
                  (fn (({id=tv1,...}, {id=tv2,...}), eqEnv) =>
                      TvarID.Map.insert(eqEnv, tv1, tv2)
                  )
                  TvarID.Map.empty
                  tvarPairs
              end
            else
              (EU.enqueueError
                 (Symbol.symbolToLoc name, 
                  E.ProvideArity("CP-030",{longsymbol = path@[tycon]}));
               raiseFail 3
              )
        val (nameTyPairList, conSpec) =
            foldr
              (fn ({symbol=vid, ty, loc}, (nameTyPairList, conSpec)) =>
                  let
                    val ty =
                        Option.map 
                          (Ty.evalTy tvarEnv evalEnv)
                          ty
                          handle e => raise e                          
                    val (actualTyOpt, conSpec) = 
                        case SymbolEnv.findi(conSpec, vid) of
                          NONE =>
                          (EU.enqueueError
                             (Symbol.symbolToLoc vid,
                              E.ProvideUndefinedCon
                                ("CP-040",{longsymbol=path@[vid]}));
                           raiseFail 4
                          )
                        | SOME (sym, tyOpt) => 
                          (Analyzers.provideCon (vid, sym, path@[sym]);
                           (tyOpt, #1 (SymbolEnv.remove(conSpec, vid))
                                   handle LibBase.NotFound => raise bug "SymbolEnv.remove"
                           )
                          )
                  in
                    ((vid, ty, actualTyOpt)::nameTyPairList, conSpec)
                  end
              )
              (nil, conSpec)
              conbind
        val _ = 
            SymbolEnv.appi
              (fn (name, _) => 
                  EU.enqueueError
                    (Symbol.symbolToLoc name,
                     E.ProvideRedundantCon("CP-050",{longsymbol=path@[name]}))
              )
              conSpec
        val _ = if SymbolEnv.isEmpty conSpec then () 
                else raiseFail 5
        val _ = 
            List.app
              (fn (name, tyOpt1, tyOpt2) =>
                  case (tyOpt1, tyOpt2) of
                    (NONE, NONE) => ()
                  | (SOME ty1, SOME ty2) => 
                    if equalTyInterface (N.emptyTypIdEquiv, eqEnv) (ty1, ty2) 
                    then ()
                    else 
                      (EU.enqueueError
                         (Symbol.symbolToLoc name,
                          E.ProvideConType("CP-060",{longsymbol=path@[name]}));
                       raiseFail 6)
                  | _ => 
                    (EU.enqueueError
                       (Symbol.symbolToLoc name,
                        E.ProvideConType("CP-070",{longsymbol = path@[name]}));
                     raiseFail 7)
              )
              nameTyPairList
        val returnEnv = VP.rebindTstr VP.PROVIDE (V.emptyEnv, tycon, defTstr)
      in
        VP.envWithVarE(returnEnv, varE)
      end
    end
      
  fun checkDatbindList path evalEnv env (datbinds:A.datbind list) =
      let
        val nameTstrTfunDatbindList =
            foldr
              (fn (datbind as {tyvars, symbol=tycon, conbind, loc},
                   nameTstrTfunDatbindList) =>
                  let
                    val defTstr = 
                        case VP.checkProvideTstr(env, tycon) of
                          NONE => (EU.enqueueError
                                     (Symbol.symbolToLoc tycon,
                                      E.ProvideUndefinedTypeName
                                        ("CP-080",{longsymbol = path@[tycon]}));
                                   raiseFail 8)
                        | SOME tstr => tstr
                    val (defTfun, defRange, varE) = 
                        case defTstr of
                          V.TSTR {tfun,defRange,...} => 
                          (tfun, defRange, SymbolEnv.empty)
                        | V.TSTR_DTY {tfun, varE, defRange,...} => 
                          (I.derefTfun tfun, defRange, varE)

                    val (conSpec, formals) = 
                        case I.derefTfun defTfun of
                          I.TFUN_VAR(ref (I.TFUN_DTY{formals, conSpec,...})) =>
                          (conSpec, formals)
                        | _ => 
                          (EU.enqueueError
                             (Symbol.symbolToLoc tycon,
                              E.ProvideDtyExpected
                                ("CP-090",{longsymbol=path@[tycon]}));
                           raiseFail 8)
                    val defRealTstr =
                        V.TSTR_DTY{tfun=defTfun,
                                   varE = varE,
                                   defRange = defRange,
                                   formals=formals,
                                   conSpec=conSpec}
                  in
                    (tycon, defTstr, defRealTstr, defTfun, datbind, varE)::
                    nameTstrTfunDatbindList
                  end
              )
              nil
              datbinds
        val evalEnv =
            foldl
              (fn ((name, defTstr, defRealTstr, tfun, dtbind, varE), evalEnv) =>
                  VP.rebindTstr VP.PROVIDE(evalEnv, name, defRealTstr))
              evalEnv
              nameTstrTfunDatbindList
      in
        foldl
          (fn (nameTstrTfunBind, returnEnv) =>
              let
                val newEnv =
                    checkDatbind path evalEnv env nameTstrTfunBind
              in
                VP.unionEnv "CP-100" (returnEnv, newEnv)
              end
          )
          V.emptyEnv
          nameTstrTfunDatbindList
      end

  fun checkPidec 
        exnSet
        path
        (evalTopEnv as {Env=evalEnv,FunE, SigE}) 
        (env, pidec) =
(*
(U.print "*** checkPidec \n";
*)
      case pidec of
        (* val name ... *)
        PI.PIVAL {scopedTvars, symbol=name, body, loc} =>
        let
          val internalLongsymbol = path @ [name]
          (* for declaration and error message *)
          val (tvarEnv, scopedTvars) =
              Ty.evalScopedTvars Ty.emptyTvarEnv evalEnv scopedTvars
        in
          case body of
            (* val name : ty *)
            A.VAL_EXTERN {ty} => 
            let
               val externLongsymbol = internalLongsymbol
               val bodyTy = Ty.evalTy tvarEnv evalEnv ty handle e => raise e
               val ty = case scopedTvars of
                          nil => bodyTy
                        | _ => I.TYPOLY(scopedTvars, bodyTy)
               fun makeDecl icexp defRange = 
                   let
                     val icexp =  I.ICINTERFACETYPED {icexp=icexp, path=path@[name], ty=bodyTy, loc=loc}
                     val newId = VarID.generate()
                     val icpat = 
                         if isOpaque ty 
                         then I.ICPATVAR_OPAQUE {longsymbol=externLongsymbol,id=newId}
                         else I.ICPATVAR_TRANS {longsymbol=externLongsymbol,id=newId}
                   in
                     (newId,
                      VP.rebindId VP.PROVIDE
                        (V.emptyEnv,
                         name,
                         I.IDVAR_TYPED {id=newId, 
                                        ty=ty, 
                                        longsymbol=externLongsymbol,
                                        defRange = defRange}),
                      [I.ICVAL(scopedTvars, [(icpat, icexp)], loc)]
                     )
                   end
             in
               case VP.checkProvideId(env, name) of
                 NONE =>
                 (EU.enqueueError
                    (Symbol.symbolToLoc name, 
                     E.ProvideUndefinedID("CP-110", {longsymbol = internalLongsymbol}));
                  raiseFail 9)
               | SOME (idstatus as I.IDVAR {id, longsymbol, defRange}) =>
                 if not (isInterface ty)
                 then 
                   (exnSet,
                    VP.rebindId VP.PROVIDE (V.emptyEnv, name, idstatus),
                    {exportDecls = [I.ICEXPORTVAR {exInfo={used = ref false, 
                                                           longsymbol=externLongsymbol, 
                                                           ty=ty, version=I.SELF},
                                                   id=id}],
                     bindDecls = nil})
                 else 
                   let
                     val (newId, env, bindDecls) = 
                         makeDecl (I.ICVAR {longsymbol=longsymbol,id=id}) defRange
                   in
                     (exnSet,
                      env,
                      {bindDecls = bindDecls,
                       exportDecls = 
                       [I.ICEXPORTTYPECHECKEDVAR
                          {longsymbol=externLongsymbol, version=I.SELF, id=newId}]
                      }
                     )
                   end
               | SOME (idstatus as I.IDVAR_TYPED {id=varid, ty=varTy,longsymbol, defRange,...}) =>
                 if equalTy (N.emptyTypIdEquiv, TvarID.Map.empty) (ty, varTy) 
                 then
                   (exnSet,
                    VP.rebindId VP.PROVIDE (V.emptyEnv,name,idstatus),
                    {exportDecls = 
                     [I.ICEXPORTTYPECHECKEDVAR
                        {id=varid, longsymbol=externLongsymbol, version=I.SELF}
                     ],
                     bindDecls= nil
                    }
                   )
                 else
                   let
                     val (newId, env, bindDecls) = 
                         makeDecl (I.ICVAR {longsymbol=longsymbol,id=varid}) defRange
                   in
                     (exnSet,
                      env,
                      {bindDecls = bindDecls,
                       exportDecls = 
                       [I.ICEXPORTVAR
                          {exInfo = {used = ref false, 
                                     ty = ty, 
                                     longsymbol=externLongsymbol, 
                                     version=I.SELF},
                           id = newId}
                       ]
                      }
                     )
                   end
               | SOME (idstatus as I.IDEXVAR {exInfo as {ty = exInfoTy, ...}, 
                                              defRange,
                                              internalId}) =>
                 (* bug 069_open, bug 124_open *)
                 let
                   val _ = #used exInfo  := true
                   val icexp  = I.ICEXVAR {exInfo=exInfo, longsymbol=internalLongsymbol}
                   val (newId, env, bindDecls) = makeDecl icexp defRange
                   val exportDecls = 
                       [I.ICEXPORTVAR 
                          {id=newId,
                           exInfo={used = ref false, longsymbol=externLongsymbol,
                                   ty = ty, version=I.SELF}}
                       ]
                 in
                   (exnSet,
                    env,
                    {bindDecls = bindDecls, exportDecls = exportDecls}
                   )
                 end
               | SOME (I.IDEXVAR_TOBETYPED _) => raise bug "IDEXVAR_TOBETYPED"
               | SOME (idstatus as I.IDBUILTINVAR {primitive, ty=primTy, defRange}) =>
                 (* bug 075_builtin *)
                 let
                   val icexp = I.ICBUILTINVAR{primitive=primitive,ty=primTy,loc=loc}
                   val (newId, env, bindDecls) = makeDecl icexp defRange
                   val exportDecls = 
                       [I.ICEXPORTVAR 
                          {id=newId,
                           exInfo={used = ref false, longsymbol=externLongsymbol,
                                   ty=ty, version=I.SELF}}
                       ]
                 in
                   (exnSet,
                    env,
                    {bindDecls = bindDecls, exportDecls = exportDecls}
                   )
                 end
               | SOME (idstatus as I.IDCON {id=conId, ty=conTy, defRange,...}) =>
                 let
                   val icexp  =I.ICCON {longsymbol=internalLongsymbol,ty=conTy, id=conId}
                   val (newId, env, bindDecls) = makeDecl icexp defRange
                   val exportDecls = 
                       [I.ICEXPORTVAR 
                          {id=newId,
                           exInfo={used = ref false, longsymbol=externLongsymbol,
                                   ty=ty, version=I.SELF}}
                       ]
                 in
                   (exnSet,
                    env,
                    {bindDecls = bindDecls, exportDecls = exportDecls}
                   )
                 end
               | SOME (idstatus as I.IDEXN {id, ty=exnTy, defRange,...}) =>
                 let
                   val icexp  =I.ICEXN {longsymbol=internalLongsymbol,ty=exnTy,id=id}
                   val (newId, env, bindDecls) = makeDecl icexp defRange
                   val exportDecls = 
                       [I.ICEXPORTVAR 
                          {id=newId,
                           exInfo={used = ref false, longsymbol=externLongsymbol,
                                   ty=ty, version=I.SELF}}
                       ]
                 in
                   (exnSet,
                    env,
                    {bindDecls = bindDecls, exportDecls = exportDecls}
                   )
                 end
               | SOME (idstatus as I.IDEXNREP {id, ty=exnTy, defRange,...}) =>
                 let
                   val _ = 
                       if equalTyInterface (N.emptyTypIdEquiv, TvarID.Map.empty) (ty, exnTy) then
                         ()
                       else
                         (EU.enqueueError
                            (Symbol.symbolToLoc name,
                             E.ProvideIDType ("CP-131", {longsymbol = internalLongsymbol})))
                   val icexp  =I.ICEXN {longsymbol=internalLongsymbol,ty=exnTy,id=id}
                   val (newId, env, bindDecls) = makeDecl icexp defRange
                   val exportDecls = 
                       [I.ICEXPORTVAR 
                          {id=newId,
                           exInfo={used = ref false, longsymbol=externLongsymbol,
                                   ty=ty, version=I.SELF}}
                       ]
                 in
                   (exnSet,
                    env,
                    {bindDecls = bindDecls, exportDecls = exportDecls}
                   )
                 end
               | SOME (I.IDEXEXN _) => raise bug "IDEXEXN in env"
               | SOME (I.IDEXEXNREP _) => raise bug "IDEXEXN in env"
               | SOME (I.IDOPRIM _) => raise bug "IDOPRIM in env"
               | SOME (I.IDSPECVAR _) => raise bug "IDSPECVAR in provideEnv"
               | SOME (I.IDSPECEXN _ ) => raise bug "IDSPECEXN in provideEnv"
               | SOME (I.IDSPECCON _) => raise bug "IDSPECCON in provideEnv"
             end (* val name : ty *)

          | (* val name = aliasPath *)
            A.VALALIAS_EXTERN aliasPath =>
            (case VP.checkProvideId(env, name) of
               NONE =>
               (EU.enqueueError
                  (Symbol.symbolToLoc name,
                   E.ProvideUndefinedID("CP-130", {longsymbol = path@[name]}));
                raiseFail 10)
             | SOME (I.IDEXVAR {exInfo={used=used1, longsymbol=refSym, ty, version},  
                                            internalId, defRange = defRange1}) =>
               (case VP.checkProvideAliasId(name, evalEnv, aliasPath) of
                  SOME (idstatus as 
                       I.IDEXVAR (exInfo as {exInfo={used=used2, longsymbol=defSym, ty, version},
                                             defRange = defRange2,
                                             internalId})) =>
                  let
                    val exInfo = exInfo # {defRange = defRange1}
                  in
                  if Symbol.eqLongsymbol(refSym, defSym) then
                    (used1 := true; used2:=true;
                     (exnSet, 
                      VP.rebindId VP.PROVIDE (V.emptyEnv,name, I.IDEXVAR exInfo), 
                      {exportDecls=nil, bindDecls=nil}
                     )
                    )
                  else 
                    (EU.enqueueError
                       (Symbol.longsymbolToLoc defSym, 
                        E.ProvideVariableAlias("CP-140", {longsymbol = defSym}));
                     raiseFail 11)
                  end
                | SOME _ =>
                  (EU.enqueueError
                     (Symbol.longsymbolToLoc aliasPath,
                      E.ProvideVariableAlias("CP-150", {longsymbol = aliasPath}));
                   raiseFail 12)
                | NONE =>
                  (EU.enqueueError
                     (Symbol.longsymbolToLoc aliasPath, 
                      E.ProvideUndefinedID("CP-160", {longsymbol = aliasPath}));
                   raiseFail 13)
               )
             | SOME (idstatus as I.IDBUILTINVAR {primitive=refPrim, ...}) =>
               (case VP.checkProvideAliasId(name, evalEnv, aliasPath) of
                  SOME (I.IDBUILTINVAR {primitive=defPrim, ...}) =>
                  if refPrim = defPrim then
                    (exnSet, 
                     VP.rebindId VP.PROVIDE (V.emptyEnv,name,idstatus), 
                     {exportDecls=nil, bindDecls=nil}
                    )
                  else
                    (EU.enqueueError
                       (Symbol.longsymbolToLoc aliasPath, 
                        E.ProvideVariableAlias("CP-170", {longsymbol = aliasPath}));
                     raiseFail 14)
                | SOME _ =>
                  (EU.enqueueError
                     (Symbol.longsymbolToLoc aliasPath,
                      E.ProvideVariableAlias("CP-180", {longsymbol = aliasPath}));
                   raiseFail 15)
                | NONE =>
                  (EU.enqueueError
                     (Symbol.longsymbolToLoc aliasPath,
                      E.ProvideUndefinedID("CP-190", {longsymbol = aliasPath}));
                   raiseFail 16)
               )
             | SOME (idstatus as (I.IDVAR {id=refId,...})) =>
               (case VP.checkProvideAliasId(name, evalEnv, aliasPath) of
                  SOME (idstatus as (I.IDVAR {id=defId,...})) =>
                  if VarID.eq(refId,defId) then
                    (exnSet, 
                     VP.rebindId VP.PROVIDE (V.emptyEnv,name,idstatus), 
                     {exportDecls=nil, bindDecls=nil}
                    )
                  else 
                    (EU.enqueueError
                       (Symbol.longsymbolToLoc aliasPath,
                        E.ProvideVariableAlias("CP-200", {longsymbol = aliasPath}));
                     raiseFail 17)
                | SOME (idstatus as (I.IDVAR_TYPED {id=defId, ty,...})) =>
                  if VarID.eq(refId,defId) then
                    (exnSet, 
                     VP.rebindId VP.PROVIDE (V.emptyEnv,name,idstatus), 
                     {exportDecls=nil, bindDecls=nil}
                    )
                  else 
                    (EU.enqueueError
                       (Symbol.longsymbolToLoc aliasPath,
                        E.ProvideVariableAlias("CP-201", {longsymbol = aliasPath}));
                     raiseFail 18)
                | SOME _ =>
                  (EU.enqueueError
                     (Symbol.longsymbolToLoc aliasPath, 
                      E.ProvideVariableAlias("CP-210", {longsymbol = aliasPath}));
                   raiseFail 19)
                | NONE =>
                  (EU.enqueueError
                     (Symbol.longsymbolToLoc aliasPath,
                      E.ProvideUndefinedID("CP-220", {longsymbol = aliasPath}));
                   raiseFail 20)
               )
             | SOME (idstatus as (I.IDVAR_TYPED {id=refId, ty,...})) =>
               (case VP.checkProvideAliasId(name, evalEnv, aliasPath) of
                  SOME (idstatus as (I.IDVAR {id=defId,...})) =>
                  if VarID.eq(refId,defId) then
                    (exnSet, 
                     VP.rebindId VP.PROVIDE (V.emptyEnv,name,idstatus), 
                     {exportDecls=nil, bindDecls=nil}
                    )
                  else 
                    (EU.enqueueError
                       (loc, E.ProvideVariableAlias("CP-200", {longsymbol = internalLongsymbol}));
                     raiseFail 21)
                | SOME (idstatus as (I.IDVAR_TYPED {id=defId, ty,...})) =>
                  if VarID.eq(refId,defId) then
                    (exnSet, 
                     VP.rebindId VP.PROVIDE (V.emptyEnv,name,idstatus), 
                     {exportDecls=nil, bindDecls=nil}
                    )
                  else 
                    (EU.enqueueError
                       (loc, E.ProvideVariableAlias("CP-201", {longsymbol = internalLongsymbol}));
                     raiseFail 22)
                | SOME _ =>
                  (EU.enqueueError
                     (loc, E.ProvideVariableAlias("CP-210", {longsymbol = internalLongsymbol}));
                   raiseFail 23)
                | NONE =>
                  (EU.enqueueError
                     (loc, E.ProvideUndefinedID("CP-220", {longsymbol = internalLongsymbol}));
                   raiseFail 24)
               )
             | SOME _ =>
               (EU.enqueueError
                  (loc, E.ProvideVarIDExpected("CP-230", {longsymbol = internalLongsymbol}));
                raiseFail 25)
            ) (* val symbol = symbol *)
          | (* val symbol = _builtin symbol : ty *)
            A.VAL_BUILTIN {builtinSymbol, ty} =>
            (case BuiltinPrimitive.findPrimitive
                    (Symbol.symbolToString builtinSymbol) of
               NONE =>
               (EU.enqueueError
                  (symbolToLoc builtinSymbol,
                   E.PrimitiveNotFound ("EI-080", {symbol = builtinSymbol}));
                raiseFail 26)
             | SOME prim =>
               (exnSet,
                VP.rebindId VP.PROVIDE
                  (V.emptyEnv, name,
                   I.IDBUILTINVAR
                     {primitive = prim,
                      defRange = loc,
                      ty = Ty.evalTy tvarEnv evalEnv ty}),
                {exportDecls=nil, bindDecls=nil}))
          | (* val symbol = case tyvar of ... *)
            A.VAL_OVERLOAD overloadCase =>
            let
              (* check only *)
              fun checkOverloadInstance (A.INST_OVERLOAD overloadCase) =
                  ignore (checkOverloadCase overloadCase)
                | checkOverloadInstance (A.INST_LONGVID {longsymbol}) =
                  case VP.checkProvideAliasId(name, evalEnv, longsymbol) of
                    SOME (I.IDEXVAR _) => ()
                  | SOME (I.IDBUILTINVAR _) => ()
                  | SOME (I.IDVAR _) => ()
                  | SOME (I.IDVAR_TYPED _) => ()
                  | SOME _ =>
                    (EU.enqueueError
                       (Symbol.symbolToLoc name,
                        E.ProvideVarIDExpected
                          ("CP-230", {longsymbol = longsymbol}));
                     raiseFail 27)
                  | NONE =>
                    (EU.enqueueError
                       (Symbol.symbolToLoc name,
                        E.ProvideUndefinedID
                          ("CP-130", {longsymbol = longsymbol}));
                     raiseFail 28)
              and checkOverloadMatch {instTy, instance} =
                  {instTy = Ty.evalTy tvarEnv evalEnv instTy,
                   instance = checkOverloadInstance instance}
              and checkOverloadCase {tyvar, expTy, matches, loc} =
                  {tvar = Ty.evalTvar tvarEnv tyvar,
                   expTy = Ty.evalTy tvarEnv evalEnv expTy,
                   matches = (map checkOverloadMatch matches; nil),
                   loc = loc}
              val id = OPrimID.generate ()
            in
              (exnSet,
               VP.rebindId VP.PROVIDE
                 (V.emptyEnv, name,
                  I.IDOPRIM
                    {id = id,
                     overloadDef =
                       I.ICOVERLOADDEF
                         {boundtvars = scopedTvars,
                          id = id,
                          longsymbol = internalLongsymbol,
                          overloadCase = checkOverloadCase overloadCase,
                          loc = loc},
                     used = ref false,
                     defRange = loc,
                     longsymbol = internalLongsymbol}),
               {exportDecls=nil, bindDecls=nil})
            end
        end (* val name ... *)

      | (* type 'a foo = ty  *)
        PI.PITYPE {tyvars, symbol=name, ty, loc} =>
        let
          val internalLongsymbol = path @ [name]
          val _ = EU.checkSymbolDuplication
                    (fn {symbol, isEq} => symbol)
                    tyvars
                    (fn s => E.DuplicateTypParms("CP-240",s))
          val (tvarEnv, tvarList) = Ty.genTvarList Ty.emptyTvarEnv tyvars
          val ty = Ty.evalTy tvarEnv evalEnv ty handle e => raise e
          val tfunSpec =
              case N.tyForm tvarList ty of
                N.TYNAME tfun => tfun
              | N.TYTERM ty =>
                let
                  val admitsEq = N.admitEq tvarList ty
                in
                  I.TFUN_DEF {admitsEq=admitsEq,
                              longsymbol = internalLongsymbol,
                              formals=tvarList,
                              realizerTy=ty
                             }
                end
          val tstrDef =
              case VP.checkProvideTstr(env, name) of
                NONE =>
                (EU.enqueueError
                   (loc,
                    E.ProvideUndefinedTypeName("CP-250",{longsymbol = internalLongsymbol}));
                 raiseFail 29)
              | SOME tstr => tstr
          val tfunDef = 
              case tstrDef of
                V.TSTR {tfun,...} => I.derefTfun tfun
              | V.TSTR_DTY {tfun,...} => I.derefTfun tfun
          val _ =
              if equalTfunInterface N.emptyTypIdEquiv (tfunSpec, tfunDef) then  ()
              else 
                (
                 EU.enqueueError
                   (loc, E.ProvideInequalTfun("CP-260",{longsymbol = internalLongsymbol}));
                 raiseFail 30)
        in
          (exnSet, 
           VP.rebindTstr VP.PROVIDE (V.emptyEnv, name, tstrDef), 
           {exportDecls=nil, bindDecls=nil}
          )
        end (* type 'a foo = ty  *)

      | (* type 'a foo (= runtimeTy )  *)
        PI.PIOPAQUE_TYPE {eq, tyvars, symbol=name, runtimeTy, loc} =>
        let
(*
val _ = U.print "*** PI.PIOPAQUE_TYPE in checkPidec\n"
*)
          val internalLongsymbol = path @ [name]
          val _ = EU.checkSymbolDuplication
                    (fn {symbol, isEq} => symbol)
                    tyvars
                    (fn s => E.DuplicateTypParms("CP-270",s))
          val (tvarEnv, tvarList) = Ty.genTvarList Ty.emptyTvarEnv tyvars
          val tstrDef =
              case VP.checkProvideTstr(env, name) of
                NONE =>
                (EU.enqueueError
                   (loc,
                    E.ProvideUndefinedTypeName("CP-280",{longsymbol = internalLongsymbol}));
                 raiseFail 31)
              | SOME tstr => tstr
          val tfunDef = 
              case tstrDef of
                V.TSTR {tfun,...} => I.derefTfun tfun
              | V.TSTR_DTY {tfun,...} => I.derefTfun tfun
(*
val _ = U.print "** tfunDef **\n"
val _ = U.printTfun tfunDef
val _ = U.print "\n"
*)
          val defProp =
              case I.tfunProperty tfunDef of
                SOME prof => prof
              | NONE => raiseFail 32 (* may reach here if tfunDef is TYERROR *)
          val absProp = Ty.getProperty tvarEnv evalEnv runtimeTy loc
(*
val _ = U.print "** defProp **\n"
val _ = U.printProp defProp
val _ = U.print "\n"
val _ = U.print "** absProp **\n"
val _ = U.printProp absProp
val _ = U.print "\n"
*)
          val _ =
              if Ty.compatProperty {abs=absProp, impl=defProp}
              then  ()
              else 
                (
                 EU.enqueueError
                   (loc, E.ProvideRuntimeType("CP-290",{longsymbol = internalLongsymbol}));
                 raiseFail 33)
          val arity = I.tfunArity tfunDef
          val _ =
              if List.length tyvars = arity then  ()
              else 
                (EU.enqueueError
                   (loc, E.ProvideArity("CP-300",{longsymbol = internalLongsymbol}));
                 raiseFail 34)
          val _ =
              if eq andalso not (I.tfunAdmitsEq tfunDef)
              then (EU.enqueueError
                      (loc, E.ProvideEquality("CP-350",{longsymbol = internalLongsymbol}));
                    raiseFail 35)
              else ()
          val admitsEq = I.tfunAdmitsEq tfunDef
          val longsymbol  = I.tfunLongsymbol tfunDef
          val liftedTys = I.tfunLiftedTys tfunDef
          val formals = I.tfunFormals tfunDef
          val id = TypID.generate()
          val newTfun =
              I.TFUN_VAR
              (ref
                 (I.TFUN_DTY {id=id,
                             admitsEq=admitsEq,
                             formals=formals,
                             conSpec=SymbolEnv.empty,
                             conIDSet = ConID.Set.empty,
                             longsymbol=longsymbol,
                             liftedTys= liftedTys,
                             dtyKind=I.INTERFACE tfunDef
                            }
                 )
              )
          val newTstr = V.TSTR {tfun = newTfun, defRange = loc}
        in
          (exnSet, 
           VP.rebindTstr VP.PROVIDE (V.emptyEnv, name, newTstr), 
           {exportDecls=nil, bindDecls=nil}
          )
        end (* type 'a foo (= runtimeTy )  *)

      | (* datatype foo = _builtin foo *)
        PI.PITYPEBUILTIN {symbol, builtinSymbol, loc} =>
        raise bug "PITYPEBUILTIN in provideSpec"

      | (* datatype foo = datatype bar *)
        PI.PITYPEREP {symbol=tycon, longsymbol=origTycon, loc} =>
         let
           val internalPath = path @ [tycon]
           val specTstr =
               case VP.checkProvideAliasTstr(evalEnv, origTycon) of
                 NONE => (EU.enqueueError
                            (loc,
                             E.ProvideUndefinedTypeName
                               ("CP-360",{longsymbol = internalPath}));
                          raiseFail 36)
               | SOME tstr => tstr
           val specTfun =
               case specTstr of
                 V.TSTR {tfun,...} => I.derefTfun tfun
               | V.TSTR_DTY {tfun,...} => I.derefTfun tfun
           val defTstr = 
               case VP.checkProvideTstr(env, tycon) of
                 NONE => (EU.enqueueError
                            (loc,
                             E.ProvideUndefinedTypeName
                               ("CP-370",{longsymbol = internalPath}));
                          raiseFail 38)
               | SOME tstr => tstr
(* 2013-3-21 ohori bug 
           val defTfun = 
               case defTstr of
                 V.TSTR tfun => I.derefTfun tfun
               | V.TSTR_DTY {tfun,...} => I.derefTfun tfun
*)
           val (varE, defTfun) = 
               case defTstr of
                 V.TSTR {tfun,...} => (SymbolEnv.empty, I.derefTfun tfun)
               | V.TSTR_DTY {tfun,varE, ...} => (varE, I.derefTfun tfun)
         in
           if equalTfunInterface N.emptyTypIdEquiv (defTfun, specTfun) then 
             let
               val returnEnv = 
                   VP.rebindTstr VP.PROVIDE (V.emptyEnv,tycon, defTstr)
             in
               (exnSet, 
                VP.envWithVarE(returnEnv, varE),
(* 2013-3-21 ohori
                returnEnv, 
*)
                {exportDecls=nil, bindDecls=nil}
                )
             end
           else 
             (EU.enqueueError
                (loc,
                 E.ProvideDtyExpected ("CP-380",{longsymbol = internalPath}));
              raiseFail 39)
         end (* datatype foo = datatype bar *)

      | (* exception name [of ty] *)
        PI.PIEXCEPTION {symbol=name, ty=tyOpt, loc} => 
        let
          val longsymbol = path @ [name]
          val tySpec =
              case tyOpt of 
                NONE => BT.exnITy
              | SOME ty => I.TYFUNM([Ty.evalTy Ty.emptyTvarEnv evalEnv ty],
                                    BT.exnITy)
                handle e => raise e
        in
          case VP.checkProvideId (env, name) of
            NONE =>
            (EU.enqueueError
               (loc, E.ProvideUndefinedID("CP-390", {longsymbol = longsymbol}));
             raiseFail 40)
          | SOME (idstatus as I.IDEXN {id,longsymbol=_,ty, defRange}) => 
            if equalTyInterface (N.emptyTypIdEquiv, TvarID.Map.empty) (ty, tySpec) then
              (ExnID.Set.add(exnSet, id),
               VP.rebindId VP.PROVIDE (V.emptyEnv, name, idstatus),
               {exportDecls=
                [I.ICEXPORTEXN {id=id,exInfo={used = ref false, ty=ty,
                                              longsymbol=longsymbol, version=I.SELF}}],
                bindDecls=nil
               }
              )
            else 
              (
               EU.enqueueError
                 (loc, E.ProvideExceptionType("CP-400", {longsymbol = longsymbol}));
               raiseFail 42)
          | SOME (I.IDEXNREP {id,longsymbol=_, ty, defRange}) =>
            (* BUG 128_functor.sml *)
            if equalTyInterface (N.emptyTypIdEquiv, TvarID.Map.empty) (ty, tySpec)
            then
              if not (ExnID.Set.member(exnSet, id)) then
                (ExnID.Set.add(exnSet, id),
(* 2012-12-23
                 VP.rebindId(V.emptyEnv, name, I.IDEXN {id=id, longsymbol=longsymbol, ty=ty}),
*)
                 VP.rebindId VP.PROVIDE 
                             (V.emptyEnv, name, 
                              I.IDEXNREP {id=id, defRange = loc, longsymbol=longsymbol, ty=ty}),
                 {exportDecls =
                  [I.ICEXPORTEXN
                     {id=id,exInfo={used = ref false, ty=ty,
                                    longsymbol=longsymbol, version=I.SELF}}],
                  bindDecls=nil
                 }
                )
              else 
                (exnSet, 
                 V.emptyEnv, 
                 {exportDecls=
                  [I.ICEXPORTEXN
                     {id=id,exInfo={used = ref false, ty=ty,
                                    longsymbol=longsymbol, version=I.SELF}}],
                  bindDecls=nil
                 }
                )
            else 
              (EU.enqueueError
                 (loc, E.ProvideExceptionType("CP-410", {longsymbol = longsymbol}));
               raiseFail 42)
          | SOME (idstatus as I.IDEXEXN _) => 
            (EU.enqueueError
               (loc, E.ProvideExceptionType("CP-420", {longsymbol = longsymbol}));
             raiseFail 43)
          | SOME (idstatus as I.IDEXEXNREP _) => 
            (EU.enqueueError
               (loc, E.ProvideExceptionType("CP-430", {longsymbol = longsymbol}));
             raiseFail 44)
          | _ => 
            (EU.enqueueError
               (loc,
                E.ProvideUndefinedException("CP-440", {longsymbol = longsymbol}));
             raiseFail 45)
        end (* exception name [of ty] *)

      | (* exception foo = barPath *)
        PI.PIEXCEPTIONREP {symbol=name, longsymbol=origPath, loc} =>
        (
        let
          val refIdstatus = 
              case VP.checkProvideAliasId (name, evalEnv, origPath) of
                NONE =>
                (
                 EU.enqueueError
                   (loc, E.ExceptionNameUndefined
                           ("CP-450",{longsymbol = origPath}));
                 raiseFail 46)
              | SOME (idstatus as I.IDEXN _) => idstatus
              | SOME (idstatus as I.IDEXNREP _) => idstatus
              | SOME (idstatus as I.IDEXEXN _) => idstatus
              | SOME (idstatus as I.IDEXEXNREP _) => idstatus
              | _ => 
                (EU.enqueueError
                   (loc, E.ExceptionExpected
                           ("CP-460",{longsymbol = origPath}));
                 raiseFail 47)
          val defIdstatus =
              case VP.checkProvideId (env, name) of
                NONE =>
                (EU.enqueueError
                   (loc, E.ProvideUndefinedID
                           ("CP-470",{longsymbol = origPath}));
                 raiseFail 48)
              | SOME (I.IDEXN _) => 
                (EU.enqueueError
                   (loc, E.ProvideExceptionRep
                           ("CP-480",{longsymbol = origPath}));
                 raiseFail 49)
              | SOME (idstatus as I.IDEXNREP _) => idstatus
              | SOME (idstatus as I.IDEXEXN _) => idstatus
              | SOME (idstatus as I.IDEXEXNREP _) => idstatus
              | _ => 
                (EU.enqueueError
                   (loc, E.ExceptionExpected
                           ("CP-490",{longsymbol = origPath}));
                 raiseFail 50)
        in
          case defIdstatus of
            I.IDEXNREP {id=id1, ...} =>
            (case refIdstatus of
               I.IDEXN {id=id2,...} =>
               if ExnID.eq(id1, id2) then 
                 (exnSet,
                  VP.rebindId VP.PROVIDE (V.emptyEnv, name, defIdstatus),
                  {exportDecls=nil, bindDecls=nil}
                 )
               else
                 (EU.enqueueError
                    (loc, E.ProvideExceptionRepID("CP-500", {longsymbol = path@[name]}));
                  raiseFail 51)
             | I.IDEXNREP {id=id2,...} => 
               if ExnID.eq(id1, id2) then 
                 (exnSet, 
                  VP.rebindId VP.PROVIDE (V.emptyEnv, name, defIdstatus),
                  {exportDecls=nil, bindDecls=nil}
                 )
               else
                 (EU.enqueueError
                    (loc, E.ProvideExceptionRepID("CP-510", {longsymbol = path@[name]}));
                  raiseFail 52)
             | _ =>
               (EU.enqueueError
                  (loc, E.ProvideExceptionRepID("CP-520", {longsymbol = path@[name]}));
                raiseFail 53)
            )
          | I.IDEXEXN {longsymbol=longsymbol1, ...} =>
            (case refIdstatus of
               I.IDEXEXN {longsymbol=longsymbol2,...} =>
               if Symbol.eqLongsymbol (longsymbol1, longsymbol2) then 
                 (exnSet, 
                  VP.rebindId VP.PROVIDE (V.emptyEnv, name, defIdstatus), 
                  {exportDecls=nil, bindDecls=nil}
                 )
               else
                 (EU.enqueueError
                    (loc, E.ProvideExceptionRepID("CP-530", {longsymbol = path@[name]}));
                  raiseFail 54)
             | _ =>
               (EU.enqueueError
                  (loc, E.ProvideExceptionRepID("CP-540", {longsymbol = path@[name]}));
                raiseFail 55)
            )
          | I.IDEXEXNREP {longsymbol=longsymbol1, ...} =>
            (case refIdstatus of
               I.IDEXEXNREP {longsymbol=longsymbol2,...} =>
               if Symbol.eqLongsymbol(longsymbol1, longsymbol2) then 
                 (exnSet, 
                  VP.rebindId VP.PROVIDE (V.emptyEnv, name, defIdstatus),
                  {exportDecls=nil, bindDecls=nil}
                 )
               else
                 (EU.enqueueError
                    (loc, E.ProvideExceptionRepID("CP-550", {longsymbol = path@[name]}));
                  raiseFail 56)
(* 2012-9-25 ohori: added the following case due to the fix of 237_functorExn
   _require file
      exception FOO       => IDEXEXN
      exception BAR = FOO => IDEXEXNREP
   source:
     exception Foo = FOO  => IDEXEXNREP
     exception Bar = BAR  => IDEXEXNREP
   interface file: 
     exception Foo = FOO 
     exception Bar = BAR
  In this case, Foo = IDEXEXNREP and FOO = IDEXEXN
*)
             | I.IDEXEXN {longsymbol=longsymbol2,...} =>
               if Symbol.eqLongsymbol(longsymbol1, longsymbol2) then 
                 (exnSet, 
                  VP.rebindId VP.PROVIDE (V.emptyEnv, name, defIdstatus),
                  {exportDecls=nil, bindDecls=nil}
                 )
               else
                 (EU.enqueueError
                    (loc, E.ProvideExceptionRepID("CP-550", {longsymbol = path@[name]}));
                  raiseFail 57)
             | _ =>
               (EU.enqueueError
                  (loc, E.ProvideExceptionRepID("CP-560", {longsymbol = path@[name]}));
                raiseFail 58)
            )
          | _ => raise bug "impossible"
        end
        handle Fail => 
               (exnSet, 
                V.emptyEnv, 
                {exportDecls=nil, bindDecls=nil}
               )
        ) (* exception foo = barPath *)

      | (* datatype foo = ... *)
        PI.PIDATATYPE {datbind, loc} =>
        (exnSet,
         checkDatbindList path evalEnv env datbind,
         {exportDecls=nil, bindDecls=nil}
        )
      | (* structure S = struct ... end *)
        PI.PISTRUCTURE {symbol=strSymbol, strexp=PI.PISTRUCT {decs,loc=strLoc}, loc} =>
        (case VP.checkProvideStr(env, strSymbol) of
           SOME (strEntry as {env, ...}) => 
           let
             val (exnSet, returnEnv, icdecls) =
                 checkPidecList
                   exnSet strLoc (path@[strSymbol]) evalTopEnv (env, decs)
             val strEntry = strEntry # {env=returnEnv}
           in
             (exnSet, VP.rebindStr VP.PROVIDE(V.emptyEnv, strSymbol, strEntry), icdecls)
           end
         | NONE =>
           (EU.enqueueError
              (loc, E.ProvideUndefinedStr("CP-570", {longsymbol=path@[strSymbol]}));
            raiseFail 59)
        )

      | (* structure S = Spath *)
        PI.PISTRUCTURE {symbol=strSymbol, 
                        strexp=PI.PISTRUCTREP {longsymbol=strPath,loc=strLoc}, loc} =>
        (case VP.checkProvideStr(env, strSymbol) of
             SOME {env = env1, strKind,...} =>
             let
               val defId = case strKind of
                             V.STRENV id => id
                           | V.FUNAPP {id, ...} => id
                           | _ => 
                             (EU.enqueueError
                                (loc, E.ProvideStrRep("CP-580", {longsymbol=path@[strSymbol]}));
                              raiseFail 60)
             in
               (case VP.checkStr(evalEnv, strPath) of
                  SOME (strEntry as {strKind,...}) =>
                  let
                    val refId =
                        case strKind of
                          V.STRENV id => id
                        | V.FUNAPP {id,...} => id
                        | _ => 
                          (EU.enqueueError
                             (loc, E.ProvideStrRep("CP-590", {longsymbol=path@[strSymbol]}));
                           raiseFail 61)
                  in
                    if StructureID.eq(defId, refId) then 
                      (exnSet, 
(* 2012-12-23 
                       VP.rebindStr VP.PROVIDE(V.emptyEnv, strSymbol, strEntry), 
*)
                       VP.rebindStr VP.PROVIDE(V.emptyEnv, strSymbol, strEntry # {env=env1}), 
                       {exportDecls=nil, bindDecls=nil}
                      )
                    else 
                      (EU.enqueueError
                         (loc, E.ProvideStrRep("CP-600", {longsymbol=path@[strSymbol]}));
                       raiseFail 62)
                  end
                | NONE => 
                  (EU.enqueueError
                     (loc, E.ProvideUndefinedStr("CP-610", {longsymbol=strPath}));
                   raiseFail 63
                  )
               )
             end
           | NONE =>
             (EU.enqueueError
                (loc, E.ProvideUndefinedStr("CP-620", {longsymbol=path@[strSymbol]}));
              raiseFail 64)
          )  (* structure S = Spath *)

      | (* structure A = F(B) *)
        PI.PISTRUCTURE {symbol=strSymbol, 
                        strexp=PI.PIFUNCTORAPP
                                 {functorSymbol,
                                  argument, 
                                  loc=argLoc}, 
                        loc} =>
        (case VP.checkProvideStr(env, strSymbol) of
           SOME (strEntry as {env=strEnv, strKind,...}) => 
           (case strKind of
              V.FUNAPP {id, funId=funId1, argId=argId1} =>
              let
                val {FunE, Env, ...} = evalTopEnv
                val ({id=funId2,...}:V.funEEntry) = 
                    (* case SymbolEnv.find(FunE, functorSymbol) of *)
                    case VP.checkFunETopEnv(evalTopEnv, functorSymbol) of
                      SOME entry => entry
                    | NONE =>
                      (EU.enqueueError
                         (loc,E.ProvideUndefinedFunctorName
                                ("CP-630",{longsymbol = [functorSymbol]}));
                       raiseFail 65)
                val {strKind=argStrKind, env=_, ...} = 
                    case VP.checkStr(Env, argument) of
                      SOME entry => entry
                    | NONE => 
                      (EU.enqueueError
                         (loc, E.StrNotFound ("CP-640",{longsymbol = argument}));
                       raiseFail 66)
                val argId2 = 
                    case argStrKind of
                      V.STRENV id => id
                    | V.FUNAPP {id,...} => id
                    | _ => 
                      (EU.enqueueError
                         (loc, E.StrNotFound ("CP-650",{longsymbol = argument}));
                       raiseFail 67)
                val _ = if FunctorID.eq(funId1, funId2) then ()
                        else 
                          (
                           EU.enqueueError
                             (loc,
                              E.ProvideFunctorIdMismatchInFunapp
                                ("CP-660",{longsymbol = [functorSymbol]}));
                           raiseFail 68)
                val _ = if StructureID.eq(argId1, argId2) then ()
                        else 
                          (
                           EU.enqueueError
                             (loc,
                              E.ProvideParamIdMismatchInFunapp
                                ("CP-665",{longsymbol = argument}));
                           raiseFail 69)
                val (exnSet, icdecls) = 
                    genTypedExportVarsEnv
                      (path@[strSymbol]) strEnv (exnSet,{exportDecls=nil, bindDecls=nil})
              in
                (exnSet, 
                 VP.rebindStr VP.PROVIDE(V.emptyEnv, strSymbol, strEntry), 
                 icdecls)
              end
            | _ => 
              (EU.enqueueError
                 (loc, E.ProvideUndefinedStr("CP-670", {longsymbol=path@[strSymbol]}));
               raiseFail 70)
           )
         | _ => 
           (EU.enqueueError
              (loc, E.ProvideUndefinedStr("CP-680", {longsymbol=path@[strSymbol]}));
            raiseFail 71)
        )
(*
  ) 
*)

  and checkPidecList 
        exnSet
        loc
        path
        (evalTopEnv as {Env=evalEnv, FunE, SigE}) 
        (env, declList) =
      foldl
        (fn (decl, (exnSet, returnEnv, {exportDecls, bindDecls})) =>
            let
               val evalEnv = VP.envWithEnv (evalEnv, returnEnv)
               val evalTopEnv = {Env=evalEnv, FunE=FunE, SigE=SigE}
               val (exnSet, newEnv, {exportDecls=newExportDecls, bindDecls=newBindDecls}) =
                   checkPidec exnSet path evalTopEnv (env, decl)
               val returnEnv = VP.unionEnv "CP-690" (returnEnv, newEnv)
            in
              (exnSet, returnEnv, {exportDecls=exportDecls@newExportDecls,
                                   bindDecls=bindDecls@newBindDecls})
            end
        )
        (exnSet, 
         V.emptyEnv, 
         {exportDecls=nil, bindDecls=nil}
        )
        declList


  fun checkPitopdec 
        exnSet
        (evalTopEnv as {Env=evalEnv, FunE=evalFunE, SigE=evalSigE})
        (topEnv as {Env, FunE, SigE}, pitopDec) =
      case pitopDec of
        PI.PIDEC pidec =>
        let
          val (exnSet, env, decls) =
              checkPidec exnSet nilPath evalTopEnv (Env, pidec)
        in
          (exnSet, VP.topEnvWithEnv(V.emptyTopEnv, env), decls)
        end
      | PI.PIFUNDEC (piFunbind as
                    {functorSymbol,
                     param={strSymbol, sigexp=specArgSig},
                     strexp=specBodyStr,
                     loc})
        =>
        let
          val funEEntry
                as {id, loc, version, argSigEnv, argStrEntry, argStrName, polyArgTys,
                    dummyIdfunArgTy, typidSet, exnIdSet, bodyEnv, bodyVarExp}
            =
            case VP.checkProvideFunETopEnv(topEnv, functorSymbol) of
              NONE =>
              (EU.enqueueError
                 (symbolToLoc functorSymbol,
                  E.ProvideUndefinedFunctorName("CP-700",{longsymbol=[functorSymbol]}));
               raiseFail 72
              )
            | SOME entry => entry
          val {env=specArgSigEnv,...} = Sig.evalPlsig evalTopEnv specArgSig
          val _ = if EU.isAnyError () then raiseFail 73
                  else if FU.eqSize(specArgSigEnv, argSigEnv) 
(*
                          andalso FU.eqEnv {specEnv=specArgSigEnv, implEnv=argSigEnv} then ()
*)
                          andalso FU.eqShape (specArgSigEnv, argSigEnv)
                  then
                    FU.eqEnv {specEnv=specArgSigEnv, implEnv=argSigEnv}
                  else
                    (
                     EU.enqueueError
                       (loc,
                        E.ProvideFunparamMismatch("CP-710",
                                                  {longsymbol=[functorSymbol]}));
                     raiseFail 74
                    )

          val argEnv = VP.rebindStr VP.PROVIDE(V.emptyEnv, strSymbol, argStrEntry)
          val evalEnv = VP.topEnvWithEnv (evalTopEnv, argEnv)
          val (_, {env=specBodyInterfaceEnv, strKind, ...}, _) =
              EI.evalPistr I.SELF [functorSymbol] evalEnv (LongsymbolSet.empty, specBodyStr)
          val specBodyEnv = EI.internalizeEnv specBodyInterfaceEnv
(*
val _ = U.print "eqEnv in checkprovide decfun\n"
val _ = U.print "specBodyEnv\n"
val _ = U.printEnv specBodyEnv
val _ = U.print "\n"
val _ = U.print "bodyEnv\n"
val _ = U.printEnv bodyEnv
val _ = U.print "\n"
*)

          val _ = if EU.isAnyError () then raiseFail 75
                  else if FU.eqEnv {specEnv=specBodyEnv, implEnv=bodyEnv} then 
                    ()
                  else 
                    (
                     EU.enqueueError
                       (loc,E.ProvideFunctorMismatch("CP-720",{longsymbol=[functorSymbol]}));
                     raiseFail 76
                    )
          val typidSet = FU.typidSet specBodyEnv
          val (allVars,exnIdSet) = FU.varsInEnv (specBodyEnv, loc)

(*
val _ = U.print "checkPitopdec: allVars\n"
val _ = app (fn (x,_) => (U.printLongsymbol x; U.print " \n")) allVars
val _ = U.print "\n"
*)
          fun varToTy (_, var) =
              case var of
                I.ICEXVAR {exInfo={ty,...},...} => ty
              | I.ICEXN {ty,...} => ty
              | I.ICEXN_CONSTRUCTOR _ => BT.exntagITy
              | _ =>  raise bug "VARTOTY\n"
          val bodyTy =
              case allVars of
                nil => BT.unitITy
              | _ => I.TYRECORD {ifFlex=false,
                                 fields=RecordLabel.tupleMap (map varToTy allVars)}
          val (extraTvars, firstArgTy) = 
              case dummyIdfunArgTy of
                NONE => (nil, NONE)
              | SOME (ty as I.TYRECORD {ifFlex,fields}) => 
                (map (fn (I.TYVAR tvar) => tvar
                       | _ => raise bug "non tvar in dummyIdfunArgTy")
                     (RecordLabel.Map.listItems fields),
                 SOME (I.TYFUNM([ty],ty)))
              | _ => raise bug "non record ty in dummyIdfunArgTy"

          (* four possibilities in functorTy 
             1. TYPOLY(btvs, TYFUNM([first], TYFUNM(polyList, body)))
                ICFNM1([first], ICFNM1_POLY(polyPats, BODY))
             2. TYPOLY(btvs, TYFUNM([first], body))
                ICFNM1([first], BODY)
             3. TYFUNM(polyList, body)
                ICFNM1_POLY(polyPats, BODY)
             4. TYFUNM([unit], body)
                ICFNM1(UNIT, BODY)
            where body is either
              unit (TYCONSTRUCT ..) 
             or
              record (TYRECORD ..)
            BODY is ICLET(..., ICCONSTANT or ICRECORD)
           *)
          val functorTy1 =
              case polyArgTys of
                nil => bodyTy
              | _ => I.TYFUNM(polyArgTys, bodyTy)

          val functorTy2 =
              case firstArgTy of
                NONE => functorTy1
              | SOME ty => 
                I.TYPOLY
                  (map (fn x => (x, I.UNIV I.emptyProperties)) extraTvars,
                   I.TYFUNM([ty], functorTy1))

          val functorTy =
              case functorTy2 of
                I.TYPOLY _ => functorTy2
              | I.TYFUNM _ => functorTy2
              | _ => I.TYFUNM([BT.unitITy], functorTy2)

          val exportDecls =
              case bodyVarExp of 
                I.ICVAR {longsymbol, id} => 
                [I.ICEXPORTFUNCTOR 
                   {exInfo={used = ref false, longsymbol=longsymbol, ty=functorTy, version=I.SELF}, 
                    id=id}
                ]
              | I.ICEXVAR _ => nil
              | _ => raise bug "nonvar in bodyVarExp"
          val funEEntry =
              {id=id, 
               loc = loc,
               version = I.SELF,
               argSigEnv=argSigEnv, 
               argStrEntry=argStrEntry, 
               argStrName=argStrName, 
               dummyIdfunArgTy=dummyIdfunArgTy, 
               polyArgTys=polyArgTys, 
               typidSet=typidSet, 
               exnIdSet=exnIdSet, 
               bodyEnv=bodyEnv, 
               bodyVarExp=bodyVarExp
              }

          (* val funE =  SymbolEnv.singleton(functorSymbol, funEEntry) *)
          val funE =  SymbolEnv.singleton(functorSymbol, funEEntry)
          val returnTopEnv = VP.topEnvWithFunE(V.emptyTopEnv, funE)
        in
          (exnSet, 
           returnTopEnv, 
           {exportDecls=exportDecls,
            bindDecls=nil}
           )
        end

in
  fun checkProvideFunctorBody
        {topEnv:V.topEnv, evalEnv:V.topEnv, argSigEnv:V.env, 
         specArgSig:PL.plsigexp, defLoc:Loc.loc,
         functorSymbol:Symbol.symbol, returnEnv:V.env, 
         specBodyStr:PI.pistrexp, specLoc:Loc.loc} =
      let
        val {env = specArgSigEnv,...} = Sig.evalPlsig topEnv specArgSig
        val _ = if FU.eqSize(specArgSigEnv, argSigEnv) 
                   andalso FU.eqShape (specArgSigEnv, argSigEnv)
                then
                  FU.eqEnv {specEnv=specArgSigEnv, implEnv=argSigEnv}
                else
                  (
                   EU.enqueueError
                     (defLoc,
                      E.ProvideFunparamMismatch("CP-710",
                                                {longsymbol=[functorSymbol]}));
                   raiseFail 77
                  )
        val pidec = PI.PISTRUCTURE {symbol=functorSymbol, strexp=specBodyStr, loc=specLoc}
        val strKind = V.STRENV (StructureID.generate())
(*
        val strEntry = {env=returnEnv, strKind=strKind, loc=Loc.noloc}
*)
        val loc = Symbol.symbolToLoc functorSymbol
        val strEntry = {env=returnEnv, strKind=strKind, loc=loc, definedSymbol = [functorSymbol]}
        val bodyEnv = VP.rebindStr VP.PROVIDE(V.emptyEnv, functorSymbol, strEntry)
        val (exnSet, bodyEnv as V.ENV{strE=V.STR strMap,...}, {exportDecls, bindDecls}) =
            checkPidec ExnID.Set.empty nilPath evalEnv (bodyEnv, pidec)
        val newEnv = 
            case SymbolEnv.find(strMap, functorSymbol) of
              NONE => raise bug "impossible"
            | SOME {env,...} => env
      in
        (bindDecls, newEnv)
      end
      handle Fail => (nil, returnEnv)

  (* 
     evalTopEnv: the top-level environment constructred so far
     topEnv : the top-level environment of the current declarations 
              to be checked
   *)
  fun checkPitopdecList
        (evalTopEnv: NameEvalEnv.topEnv)
        (topEnv:NameEvalEnv.topEnv, pitopdecList:PatternCalcInterface.pitopdec list) 
       : {exportDecls:IDCalc.icdecl list, bindDecls:IDCalc.icdecl list} =
      let
        val (exnSet, returnTopEnv, icdecls) =
            foldl
              (fn (pitopdec, (exnSet, returnTopEnv, {exportDecls, bindDecls})) =>
                  let
                    val evalTopEnv = VP.topEnvWithTopEnv (evalTopEnv, returnTopEnv)
                    val (exnSet, newTopEnv, {exportDecls=newExportDecls, bindDecls=newBindDecls}) =
                        checkPitopdec exnSet evalTopEnv (topEnv,pitopdec)
                        handle e => raise e
                    val returnTopEnv =
                        VP.unionTopEnv "CP-730" (returnTopEnv, newTopEnv)
                  in
                    (exnSet, 
                     returnTopEnv, 
                     {exportDecls=exportDecls@newExportDecls,
                      bindDecls=bindDecls@newBindDecls}
                     )
                  end
              )
              (ExnID.Set.empty,
               V.emptyTopEnv, 
               {exportDecls=nil, bindDecls=nil}
              )
              pitopdecList
      in
        icdecls
      end
      handle Fail => {exportDecls=nil, bindDecls=nil}
           | exn => raise exn

end
end
