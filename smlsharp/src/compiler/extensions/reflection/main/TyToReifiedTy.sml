(**
 * @copyright (C) 2021 SML# Development Team.
 * @author Atsushi Ohori
 *)
structure TyToReifiedTy =
struct
  structure T = Types
  structure TB = TypesBasics
  structure BT = BuiltinTypes
  structure R = ReifiedTy
  structure BN = RuntimeTypes
  (* structure RU = ReifyUtils *)
  structure U = UserLevelPrimitive

  exception TyToReifiedTy
  exception InstantiateFail
  exception GetConFail

  fun printTy ty = 
     print (Bug.prettyPrint (T.format_ty ty))
  fun printReifiedTy ty = 
     print (R.reifiedTyToString ty)
  fun eqTyCon ({id=id1,...}, {id=id2,...}) = TypID.eq(id1, id2)

  fun tagMapToSEnv tagMap =
      #2 (foldl (fn (x, (i, z)) => (i + 1, SEnv.insert (z, x, i)))
                (0, SEnv.empty)
                tagMap)

  fun isOpaqueTycon ({dtyKind = T.DTY _, ...}:T.tyCon) = false
    | isOpaqueTycon _ = true

  fun convertLayout layout =
      case layout of
      BN.LAYOUT_TAGGED taggedLayout => R.LAYOUT_TAGGED (convertTaggedLayout taggedLayout)
    | BN.LAYOUT_ARG_OR_NULL {wrap = wrap} => R.LAYOUT_ARG_OR_NULL {wrap = wrap}
    | BN.LAYOUT_SINGLE_ARG {wrap} => R.LAYOUT_SINGLE_ARG {wrap = wrap}
    | BN.LAYOUT_CHOICE {falseName = name} => R.LAYOUT_CHOICE {falseName = name}
    | BN.LAYOUT_SINGLE => R.LAYOUT_SINGLE
    | BN.LAYOUT_REF => raise Bug.Bug "LAYOUT_REF to convertLayout"
  and convertTaggedLayout taggedLayout = 
      case taggedLayout of
      BN.TAGGED_RECORD {tagMap} =>
      R.TAGGED_RECORD {tagMap = tagMapToSEnv tagMap}
    | BN.TAGGED_OR_NULL {tagMap, nullName} =>
      R.TAGGED_OR_NULL {tagMap = tagMapToSEnv tagMap, nullName = nullName}
    | BN.TAGGED_TAGONLY {tagMap} =>
      R.TAGGED_TAGONLY {tagMap = tagMapToSEnv tagMap}

  fun oneArg [argTy] = argTy
    | oneArg _ = raise Bug.Bug "Datatype Arity"

  fun sizeOf ty = 
      case TypeLayout2.propertyOf BoundTypeVarID.Map.empty ty of
        SOME {size = BN.SIZE n, ...} => RuntimeTypes.getSize n
      | _ => 0 (* error value *)

  fun tagOf ty = 
      case TypeLayout2.propertyOf BoundTypeVarID.Map.empty ty of
        SOME {tag = BN.TAG tag, ...} =>
        (case tag of
           RuntimeTypes.BOXED => true
         | RuntimeTypes.UNBOXED => false)
      | _ => raise Bug.Bug "toReifiedTy: tagOf"

  fun traverseTy loc ty =
      let
        val traverseTy = traverseTy loc
      in
      case TB.derefTy ty of
        T.CONSTRUCTty {tyCon = {dtyKind = T.DTY _, id, conSet, longsymbol,...}, args} =>
        (case R.findConSet id of
           SOME _ => app traverseTy args
         | NONE =>
           let
             val _ = R.setConSet (id, R.emptyConSet)
             val _ = app traverseTy args
             val rigidConSet = 
                 SymbolEnv.foldli
                   (fn (label, NONE, senv) => 
                       SEnv.insert(senv, Symbol.symbolToString label, NONE)
                     | (label, SOME f, senv) => 
                       SEnv.insert(senv, Symbol.symbolToString label, SOME (f ()))
                   )
                   SEnv.empty
                   conSet
             val _ = SEnv.app
                     (fn NONE => ()
                       | SOME ty => traverseTy ty)
                     rigidConSet
             val reifiedConSet =
                 SEnv.map (fn NONE => NONE
                                 | SOME ty => SOME (toReifiedTy loc ty))
                               rigidConSet
           in
             R.setConSet(id, reifiedConSet)
           end
        )
      | T.CONSTRUCTty {tyCon, args} => app traverseTy args
      | T.SINGLETONty _ => ()
      | T.BACKENDty  _ => ()
      | T.ERRORty => ()
      | T.DUMMYty _ => ()
      | T.EXISTty _ => ()
      | T.TYVARty _ => ()
      | T.BOUNDVARty _ => ()
      | T.FUNMty (tyList, ty) =>(map traverseTy tyList; traverseTy ty)
      | T.RECORDty tyMap => RecordLabel.Map.app traverseTy tyMap
      | T.POLYty {boundtvars, constraints, body} =>
        (map traverseConstraint constraints; traverseTy body)
      end
  and traverseConstraint (T.JOIN {res, args=(ty1,ty2), loc}) =
      (traverseTy loc res; traverseTy loc ty1; traverseTy loc ty2)

  and toReifiedTy loc ty =
(*
      case TB.derefTy (Unify.forceRevealTy (TB.derefTy ty)) of
*)
      case TB.derefTy ty of
        T.BOUNDVARty tid => R.BOUNDVARty tid
      | T.CONSTRUCTty {tyCon, args} => 
        if eqTyCon (tyCon, BT.boolTyCon) then R.BOOLty
        else if eqTyCon (tyCon, BT.boxedTyCon) then R.BOXEDty
        else if eqTyCon (tyCon, BT.int32TyCon) then R.INT32ty
        else if eqTyCon (tyCon, BT.int8TyCon) then R.INT8ty
        else if eqTyCon (tyCon, BT.int16TyCon) then R.INT16ty
        else if eqTyCon (tyCon, BT.int64TyCon) then R.INT64ty
        else if eqTyCon (tyCon, BT.intInfTyCon) then R.INTINFty
        else if eqTyCon (tyCon, BT.word32TyCon) then R.WORD32ty
        else if eqTyCon (tyCon, BT.word8TyCon) then R.WORD8ty
        else if eqTyCon (tyCon, BT.word16TyCon) then R.WORD16ty
        else if eqTyCon (tyCon, BT.word64TyCon) then R.WORD64ty
        else if eqTyCon (tyCon, BT.charTyCon) then R.CHARty
        else if eqTyCon (tyCon, BT.stringTyCon) then R.STRINGty
        else if eqTyCon (tyCon, BT.real64TyCon) then R.REAL64ty
        else if eqTyCon (tyCon, BT.real32TyCon) then R.REAL32ty
        else if eqTyCon (tyCon, BT.unitTyCon) then R.UNITty
        else if eqTyCon (tyCon, BT.codeptrTyCon) then R.CODEPTRty
        else if eqTyCon (tyCon, BT.exnTyCon) then R.EXNty
        else if eqTyCon (tyCon, BT.exntagTyCon) then R.EXNTAGty
        else if eqTyCon (tyCon, BT.ptrTyCon) then 
          R.PTRty  (toReifiedTy loc (oneArg args))
        else if eqTyCon (tyCon, BT.arrayTyCon) then 
          R.ARRAYty (toReifiedTy loc (oneArg args))
        else if eqTyCon (tyCon, BT.vectorTyCon) then 
          R.VECTORty (toReifiedTy loc (oneArg args))
        else if eqTyCon (tyCon, BT.refTyCon) then 
          R.REFty (toReifiedTy loc (oneArg args))
        else if eqTyCon (tyCon, BT.listTyCon) then 
          R.LISTty (toReifiedTy loc (oneArg args))
        else if eqTyCon (tyCon, BT.optionTyCon) then 
          R.OPTIONty (toReifiedTy loc (oneArg args))
        else if eqTyCon (tyCon, BT.ptrTyCon) then 
          R.PTRty (toReifiedTy loc (oneArg args))
        else if (TypID.eq (#id tyCon, #id (U.REIFY_tyCon_SENVMAPty loc)) 
                 handle U.UserLevelPrimError _ => false) then 
          R.SENVMAPty (toReifiedTy loc (oneArg args))
        else if (TypID.eq (#id tyCon, #id (U.REIFY_tyCon_RECORDLABELty loc)) 
                 handle U.UserLevelPrimError _ => false) then 
          R.RECORDLABELty
        else if (TypID.eq (#id tyCon, #id (U.REIFY_tyCon_RecordLabelMapMap loc)) 
                 handle U.UserLevelPrimError _ => false) then 
          R.RECORDLABELMAPty (toReifiedTy loc (oneArg args))
        else if (TypID.eq (#id tyCon, #id (U.REIFY_tyCon_IENVMAPty loc)) 
                 handle U.UserLevelPrimError _ => false) then 
          R.IENVMAPty (toReifiedTy loc (oneArg args))
        else if TypID.eq (#id tyCon, #id (U.REIFY_tyCon_void loc)) then R.VOIDty 
        else if TypID.eq (#id tyCon, #id (U.REIFY_tyCon_dyn loc)) then
          R.DYNAMICty (toReifiedTy loc (oneArg args))
        else if not (isOpaqueTycon tyCon) andalso 
                not (SymbolEnv.isEmpty (#conSet tyCon)) then
          R.DATATYPEty 
            {longsymbol = #longsymbol tyCon, 
             id = #id tyCon, 
             layout = convertLayout
                        (case tyCon of
                           {dtyKind = T.DTY {rep = BN.DATA layout, ...}, ...} =>
                           layout
                         | _ => raise Bug.Bug "toReifiedTy: CONSTRUCTty"),
             args = map (toReifiedTy loc) args,
             size = sizeOf ty
            }
        else
          R.OPAQUEty
              {longsymbol = #longsymbol tyCon, 
               id = #id tyCon, 
               args = map (toReifiedTy loc) args,
               boxed = tagOf ty,
               size = sizeOf ty}
      | T.RECORDty tyFields =>
        R.RECORDty (RecordLabel.Map.map (toReifiedTy loc) tyFields)
      | T.POLYty {boundtvars, constraints, body} =>
        R.POLYty {boundenv = BoundTypeVarID.Map.mapi (fn (i,_) => i) boundtvars,
                  body = toReifiedTy loc body}
      | T.FUNMty (argTyList, resultTy) => 
        R.FUNMty (map (toReifiedTy loc) argTyList, toReifiedTy loc resultTy)
      | T.TYVARty _ => R.TYVARty
      | T.DUMMYty _ =>
        (case TypeLayout2.propertyOf BoundTypeVarID.Map.empty ty of
           SOME {size = BN.SIZE size, tag = BN.TAG tag, ...} =>
           R.DUMMYty {size = Word.fromInt (RuntimeTypes.getSize size),
                      boxed = case tag of
                                RuntimeTypes.BOXED => true
                              | RuntimeTypes.UNBOXED => false}
         | _ => raise Bug.Bug "toReifiedTy: DUMMYty")
      | T.EXISTty (id, kind) =>
        (* See InferTypes2.sml. EXISTty must be universal, non-eq and reify. *)
        (case kind of
           T.KIND {tvarKind = T.UNIV, properties, ...} =>
           if not (T.isProperties T.EQ properties) andalso
              T.isProperties T.REIFY properties
           then
             case TypeLayout2.propertyOf BoundTypeVarID.Map.empty ty of
               SOME {size, tag, ...} =>
               R.EXISTty
                 {size = case size of
                           BN.SIZE s => SOME (Word.fromInt (BN.getSize s))
                         | BN.ANYSIZE => NONE,
                  boxed = case tag of
                            BN.TAG BN.BOXED => SOME true
                          | BN.TAG BN.UNBOXED => SOME false
                          | BN.ANYTAG => NONE,
                  id = ExistTyID.toInt id}
             | NONE => raise Bug.Bug "toReifiedTy: EXISTty"
           else raise Bug.Bug "toReifiedTy: EXISTty"
         | _ => raise Bug.Bug "toReifiedTy: EXISTty")
      | T.ERRORty => R.ERRORty
      | _ => R.INTERNALty

  fun traverseReifiedTyList reifiedTyList templateConSetEnv =
      foldl
      (fn (ty, templateConSetEnv) =>
          traverseReifiedTy ty templateConSetEnv)
      templateConSetEnv
      reifiedTyList
  and traverseReifiedTy reifiedTy templateConSetEnv =
      case reifiedTy of
        R.DATATYPEty {longsymbol, id, args, layout, size} =>
        if TypID.Map.inDomain(templateConSetEnv, id) then templateConSetEnv
        else
          let
            val templateConSetEnv = 
                TypID.Map.insert(templateConSetEnv, id, R.INTERNALty)
            val conSet = case R.findConSet id of 
                           NONE => 
                             (print "findconset in travserseReifiedTy\n";
                              printReifiedTy reifiedTy;
                              print "\n";
                              print "find conset in travserseReifiedTy \n";
                              raise Bug.Bug "findconset in travserseReifiedTy")
                          | SOME conset => conset
            val reifiedTyList = 
                SEnv.foldl
                (fn (NONE, reifiedTyList) =>reifiedTyList
                  | (SOME ty, reifiedTyList) => ty::reifiedTyList)
                args
                conSet
          in
            traverseReifiedTyList reifiedTyList templateConSetEnv
          end
      | R.LISTty reifiedTy => 
        traverseReifiedTy reifiedTy templateConSetEnv
      | R.ARRAYty reifiedTy =>
        traverseReifiedTy reifiedTy templateConSetEnv
      | R.VECTORty reifiedTy =>
        traverseReifiedTy reifiedTy templateConSetEnv
      | R.OPTIONty reifiedTy =>
        traverseReifiedTy reifiedTy templateConSetEnv
      | R.REFty reifiedTy =>
        traverseReifiedTy reifiedTy templateConSetEnv
      | R.IENVMAPty reifiedTy =>
        traverseReifiedTy reifiedTy templateConSetEnv
      | R.SENVMAPty reifiedTy =>
        traverseReifiedTy reifiedTy templateConSetEnv
      | R.RECORDLABELMAPty reifiedTy =>
        traverseReifiedTy reifiedTy templateConSetEnv
      | R.RECORDty reifiedTyMap =>
        RecordLabel.Map.foldr 
        (fn (reifiedTy, templateConSetEnv) =>
            traverseReifiedTy reifiedTy templateConSetEnv)
        templateConSetEnv
        reifiedTyMap
      | R.POLYty {boundenv, body} =>
        traverseReifiedTy body templateConSetEnv
      | _ => templateConSetEnv

  fun getConSetEnv reifiedTy =
      let
        val templateConSetEnv = traverseReifiedTy reifiedTy TypID.Map.empty
        val globalConSetEnv = R.getGlobalConSetEnv ()
      in
        TypID.Map.intersectWith 
          (fn (x,y) => x)
        (globalConSetEnv, templateConSetEnv)
      end

  fun toTy loc ty = 
      let
        val _ = traverseTy loc ty
        val reifiedTy = toReifiedTy loc ty
        val conSetEnv = getConSetEnv reifiedTy
      in
        {conSetEnv = conSetEnv, reifiedTy = reifiedTy}
      end

end
