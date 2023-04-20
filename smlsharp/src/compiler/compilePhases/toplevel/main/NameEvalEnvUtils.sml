(**
 * utilities for name eval env.
 * @copyright (C) 2021 SML# Development Team.
 *)
(*
sig

  val mergeTypeEnv : NameEvalEnv.topEnv * TypeInferenceContext.varEnv
                     -> NameEvalEnv.topEnv
  val resetInternalId : NameEvalEnv.topEnv -> NameEvalEnv.topEnv
  val externOverloadInstances : NameEvalEnv.topEnv -> IDCalc.icdecl list

end 
*)
structure NameEvalEnvUtils =
struct

  structure I = IDCalc
  structure V = NameEvalEnv
  fun bug s = Bug.Bug ("MergeTypeEnv: " ^ s)

  fun setTyIdstatus tyVarE idstatus =
      case idstatus of
      I.IDVAR _ => raise bug "IDVAR not found"
    | I.IDVAR_TYPED _ => raise bug "IDVAR not found"
    | I.IDEXVAR_TOBETYPED {longsymbol, id, version, defRange} =>
      (case VarMap.find(tyVarE, {id=id, longsymbol=longsymbol}) of
         NONE => raise bug "varId not found"
       | SOME (TypedCalc.VARID {ty,...})  => 
         I.IDEXVAR {exInfo={longsymbol=longsymbol,
                            used = ref false,
                            version=version,
                            ty=I.INFERREDTY ty},
                    defRange = defRange,
                    internalId= SOME id}
       | SOME (TypedCalc.RECFUNID ({ty,...},_))  => 
         I.IDEXVAR {exInfo={longsymbol=longsymbol, 
                            version=version,
                            used = ref false, 
                            ty=I.INFERREDTY ty},
                    defRange = defRange,
                    internalId= SOME id}
      )
    | I.IDEXVAR _ => idstatus
    | I.IDBUILTINVAR _ => idstatus
    | I.IDCON _ => idstatus
    | I.IDEXN _ => idstatus
    | I.IDEXNREP _ => idstatus
    | I.IDEXEXN _ => idstatus
    | I.IDEXEXNREP _ => idstatus
(*
    | I.IDOPRIM _ => raise bug "IDOPRIM in setTy"
*)
    | I.IDOPRIM _ => idstatus  (* FIXME *)
    | I.IDSPECVAR ty => raise bug "IDSPECVAR in setTy"
    | I.IDSPECEXN ty => raise bug "IDSPECEXN in setTy"
    | I.IDSPECCON _ => raise bug "IDSPECCON in setTy"

  fun setTyVarE tyVarE varE = 
      SymbolEnv.map (setTyIdstatus tyVarE) varE

  fun setTyEnv tyVarE (NameEvalEnv.ENV {varE, tyE, strE}) =
      let
        val varE = setTyVarE tyVarE varE
        val strE = setTyStrE tyVarE strE
      in
        NameEvalEnv.ENV {varE=varE, tyE=tyE, strE=strE}
      end

  and setTyStrE tyVarE (NameEvalEnv.STR envMap) =
      NameEvalEnv.STR
        (SymbolEnv.map
           (fn strEntry as {env,...} => strEntry # {env= setTyEnv tyVarE env})
           envMap)

  fun setTyFunE tyVarE funE =
      SymbolEnv.map
      (fn {id, loc, version, argSigEnv, argStrEntry, argStrName, dummyIdfunArgTy,
                      polyArgTys, typidSet, exnIdSet, bodyEnv, bodyVarExp}
          =>
          let
            val bodyVarExp =
                case bodyVarExp of
                  I.ICEXVAR_TOBETYPED {longsymbol=internalPath, id,
                                       exInfo={used, version, longsymbol}} =>
                  let
                    val ty =
                        case VarMap.find(tyVarE, {id=id, longsymbol=longsymbol}) of
                          NONE => raise bug "varId not found"
                        | SOME (TypedCalc.VARID {ty,...}) => I.INFERREDTY ty
                        | SOME (TypedCalc.RECFUNID ({ty,...},_)) =>
                          I.INFERREDTY ty
                  in
                    I.ICEXVAR 
                      {longsymbol=internalPath,
                       exInfo={longsymbol=longsymbol, used = used,  version=version, ty= ty}}
                  end
                | _ => bodyVarExp
          in
            {id=id,
             loc = loc,
             version = version,
             argSigEnv = argSigEnv,
             argStrEntry = argStrEntry,
             argStrName = argStrName,
             dummyIdfunArgTy = dummyIdfunArgTy,
             polyArgTys = polyArgTys,
             typidSet = typidSet,
             exnIdSet = exnIdSet,
             bodyEnv = bodyEnv,
             bodyVarExp = bodyVarExp
            }
          end
      )
      funE

  fun setTy tyVarE (env as {FunE, SigE, Env}) =
      let
        val FunE = setTyFunE tyVarE FunE
        val Env = setTyEnv tyVarE Env
      in
        {FunE=FunE, SigE=SigE, Env=Env}
      end

  fun mergeTypeEnv 
        (topEnv:NameEvalEnv.topEnv, 
         tyVarE: TypeInferenceContext.varEnv)
    : NameEvalEnv.topEnv =
      setTy tyVarE topEnv

  fun resetInternalIdIdstatus idstatus =
      case idstatus of
      I.IDEXVAR {exInfo, internalId, defRange} =>
      I.IDEXVAR {exInfo=exInfo, internalId=NONE, defRange=defRange}
    | idstatus => idstatus

  fun resetInternalIdEnv (V.ENV{varE, strE, tyE}) =
      let
        val varE = SymbolEnv.map resetInternalIdIdstatus varE
        val strE = resetInternalIdStrE strE
      in
        V.ENV{varE=varE, strE=strE, tyE=tyE}
      end

  and resetInternalIdStrE (V.STR strEmap) =
      let
        val strEmap = 
            SymbolEnv.map 
            (fn (strEntry as {env, ...}) =>
                strEntry # {env=resetInternalIdEnv env}
            )
            strEmap
      in
        V.STR strEmap
      end

  fun resetInternalId ({Env, FunE, SigE}:V.topEnv) =
      let
        val Env = resetInternalIdEnv Env
      in
        {Env=Env, FunE=FunE, SigE=SigE}
      end

end
