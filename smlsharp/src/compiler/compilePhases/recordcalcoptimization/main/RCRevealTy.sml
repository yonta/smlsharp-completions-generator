(**
 * @copyright (C) 2021 SML# Development Team.
 * @author Atsushi Ohori
 *)
structure RCRevealTy =
struct
local
  structure TC = TypedCalc
  structure RC = RecordCalc
  structure T = Types
  fun bug s = Bug.Bug ("RevealTy: " ^ s)

  val revealTy = TyRevealTy.revealTy
  val revealPrimInfo  = TyRevealTy.revealPrimInfo
  val revealBtvEnv = TyRevealTy.revealBtvEnv

  fun revealFfiTy ffiTy =
      case ffiTy of
        TC.FFIBASETY (ty, loc) =>
        TC.FFIBASETY (revealTy ty, loc)
      | TC.FFIFUNTY (attribOpt (* FFIAttributes.attributes option *),
                     ffiTyList1,
                     ffiTyList2,
                     ffiTyList3,loc) =>
        TC.FFIFUNTY (attribOpt,
                     map revealFfiTy ffiTyList1,
                     Option.map (map revealFfiTy) ffiTyList2,
                     map revealFfiTy ffiTyList3,
                     loc)
      | TC.FFIRECORDTY (fields:(RecordLabel.label * TC.ffiTy) list,loc) =>
        TC.FFIRECORDTY
          (map (fn (l,ty)=>(l, revealFfiTy ty)) fields,loc)

  fun revealVar {path, ty, id} = {path=path, id = id, ty = revealTy ty}
  fun revealConInfo ({path, ty, id}:RC.conInfo) : RC.conInfo =
      {path=path, ty=revealTy ty, id=id}
  fun revealExnInfo ({path, ty, id}:RC.exnInfo) : RC.exnInfo =
      {path=path, ty=revealTy ty, id=id}
  fun revealExExnInfo ({path, ty}:RC.exExnInfo) : RC.exExnInfo =
      {path=path, ty=revealTy ty}
  fun revealOprimInfo ({ty, path, id}:RC.oprimInfo) : RC.oprimInfo =
      {ty=revealTy ty, path=path, id=id}
  fun revealExnCon (exnCon:RC.exnCon) : RC.exnCon =
      case exnCon of
        RC.EXEXN exExnInfo => RC.EXEXN (revealExExnInfo exExnInfo)
      | RC.EXN exnInfo => RC.EXN (revealExnInfo exnInfo)

  (* declaration for type constraints *)
  type ty = T.ty
  type path = RC.path
  type varInfo = {path:path, id:VarID.id, ty:ty}
  type rcexp = RC.rcexp

  fun evalExp (exp:rcexp) : rcexp =
      case exp of
        RC.RCAPPM {argExpList, funExp, funTy, loc} =>
        RC.RCAPPM {argExpList = map evalExp argExpList,
                   funExp = evalExp funExp,
                   funTy = revealTy funTy,
                   loc = loc}
        | RC.RCCASE  {defaultExp:rcexp, exp:rcexp, expTy:Types.ty, loc:Loc.loc,
                      ruleList:(RC.conInfo * varInfo option * rcexp) list,
                      resultTy} =>
          RC.RCCASE
            {defaultExp=evalExp defaultExp, 
             exp = evalExp exp,
             expTy = revealTy expTy, 
             loc=loc,
             ruleList = 
             map (fn (con, varOpt, exp) => 
                     (con, Option.map revealVar varOpt, evalExp exp))
                 ruleList,
             resultTy = revealTy resultTy
            }
        | RC.RCCAST ((rcexp, expTy), ty, loc) =>
          RC.RCCAST ((evalExp rcexp, revealTy expTy), revealTy ty, loc)
        | RC.RCCONSTANT {const, loc, ty} =>
          RC.RCCONSTANT {const=const, loc = loc, ty=revealTy ty}
        | RC.RCDATACONSTRUCT {argExpOpt, con:RC.conInfo, instTyList, loc} =>
          RC.RCDATACONSTRUCT
            {argExpOpt = Option.map evalExp argExpOpt,
             con = revealConInfo con,
             instTyList = Option.map (map revealTy) instTyList,
             loc = loc
            }
        | RC.RCEXNCASE {defaultExp:rcexp, exp:rcexp, expTy:ty, loc:Loc.loc,
                        ruleList:(RC.exnCon * varInfo option * rcexp) list,
                        resultTy} =>
          RC.RCEXNCASE
            {defaultExp=evalExp defaultExp, 
             exp = evalExp exp,
             expTy = revealTy expTy, 
             loc=loc,
             ruleList = 
             map (fn (con, varOpt, exp) => (con, Option.map revealVar varOpt, evalExp exp))
                 ruleList,
             resultTy = revealTy resultTy
            }
        | RC.RCEXNCONSTRUCT {argExpOpt, exn:RC.exnCon, loc} =>
          RC.RCEXNCONSTRUCT
            {argExpOpt = Option.map evalExp argExpOpt,
             exn = revealExnCon exn,
             loc = loc
            }
        | RC.RCEXNTAG {exnInfo, loc} =>
          RC.RCEXNTAG {exnInfo=revealExnInfo exnInfo, loc=loc}
        | RC.RCEXEXNTAG {exExnInfo, loc} =>
          RC.RCEXEXNTAG {exExnInfo=revealExExnInfo exExnInfo, loc= loc}
        | RC.RCEXVAR {path, ty} =>
          RC.RCEXVAR {path=path, ty=revealTy ty}
        | RC.RCFNM {argVarList, bodyExp, bodyTy, loc} =>
          RC.RCFNM
            {argVarList = map revealVar argVarList,
             bodyExp = evalExp bodyExp,
             bodyTy = revealTy bodyTy,
             loc = loc
            }
        | RC.RCFOREIGNSYMBOL {loc, name, ty} =>
          RC.RCFOREIGNSYMBOL {loc=loc, name=name, ty=revealTy ty}
        | RC.RCHANDLE {exnVar, exp, handler, resultTy, loc} =>
          RC.RCHANDLE {exnVar=revealVar exnVar,
                       exp=evalExp exp,
                       handler= evalExp handler,
                       resultTy=revealTy resultTy,
                       loc=loc}
        | RC.RCCATCH {catchLabel, argVarList, catchExp, tryExp, resultTy,
                      loc} =>
          RC.RCCATCH {catchLabel = catchLabel,
                      argVarList = map revealVar argVarList,
                      catchExp = evalExp catchExp,
                      tryExp = evalExp tryExp,
                      resultTy = revealTy resultTy,
                      loc = loc}
        | RC.RCTHROW {catchLabel, argExpList, resultTy, loc} =>
          RC.RCTHROW {catchLabel = catchLabel,
                      argExpList = map evalExp argExpList,
                      resultTy = revealTy resultTy,
                      loc = loc}
        | RC.RCLET {body, decls, loc} =>
          RC.RCLET {body=evalExp body,
                    decls=map evalDecl decls, 
                    loc=loc}
        | RC.RCMODIFY {elementExp, elementTy, indexExp, label, loc, recordExp, recordTy} =>
          RC.RCMODIFY
            {elementExp = evalExp elementExp,
             elementTy = revealTy elementTy,
             indexExp = evalExp indexExp,
             label = label,
             loc = loc,
             recordExp = evalExp recordExp,
             recordTy = revealTy recordTy}
        | RC.RCOPRIMAPPLY {argExp, instTyList, loc, oprimOp:RC.oprimInfo} =>
          RC.RCOPRIMAPPLY
            {argExp = evalExp argExp,
             instTyList = map revealTy instTyList,
             loc = loc,
             oprimOp = revealOprimInfo oprimOp
            }
        | RC.RCPOLY {btvEnv, exp, expTyWithoutTAbs, loc} =>
          RC.RCPOLY
            {btvEnv=revealBtvEnv btvEnv,
             exp = evalExp exp,
             expTyWithoutTAbs = revealTy expTyWithoutTAbs,
             loc = loc
            }
        | RC.RCPRIMAPPLY {argExp, instTyList, loc, primOp:T.primInfo} =>
          RC.RCPRIMAPPLY
            {argExp=evalExp argExp,
             instTyList=Option.map (map revealTy) instTyList,
             loc=loc,
             primOp=revealPrimInfo primOp
            }
        | RC.RCRAISE {exp, loc, ty} =>
          RC.RCRAISE {exp=evalExp exp, loc=loc, ty = revealTy ty}
        | RC.RCRECORD {fields:rcexp RecordLabel.Map.map, loc, recordTy} =>
          RC.RCRECORD
            {fields=RecordLabel.Map.map evalExp fields,
             loc=loc,
             recordTy=revealTy recordTy
            }
        | RC.RCSELECT {exp, expTy, indexExp, label, loc, resultTy} =>
          RC.RCSELECT
            {exp=evalExp exp,
             expTy=revealTy expTy,
             indexExp = evalExp indexExp,
             label=label,
             loc=loc,
             resultTy=revealTy resultTy
            }
        | RC.RCSIZEOF (ty, loc) =>
          RC.RCSIZEOF (revealTy ty, loc)
        | RC.RCREIFYTY (ty, loc) =>
          RC.RCREIFYTY (revealTy ty, loc)
        | RC.RCTAPP {exp, expTy, instTyList, loc} =>
          RC.RCTAPP {exp = evalExp exp,
                     expTy = revealTy expTy,
                     instTyList = map revealTy instTyList,
                     loc = loc
                    }
        | RC.RCVAR varInfo =>
          RC.RCVAR (revealVar varInfo)
        | RC.RCCALLBACKFN {attributes, resultTy, argVarList, bodyExp:rcexp,
                           loc:Loc.loc} =>
          RC.RCCALLBACKFN
            {attributes = attributes,
             resultTy = Option.map revealTy resultTy,
             argVarList = map revealVar argVarList,
             bodyExp = evalExp bodyExp,
             loc=loc}
        | RC.RCFOREIGNAPPLY {argExpList:rcexp list,
                             attributes, resultTy, funExp:rcexp,
                             loc:Loc.loc} =>
          RC.RCFOREIGNAPPLY {argExpList = map evalExp argExpList,
                             attributes = attributes,
                             resultTy = Option.map revealTy resultTy,
                             funExp = evalExp funExp,
                             loc=loc}
        | RC.RCFFI (RC.RCFFIIMPORT {ffiTy:TypedCalc.ffiTy, funExp}, ty, loc) =>
          RC.RCFFI (RC.RCFFIIMPORT 
                      {ffiTy=revealFfiTy ffiTy,
                       funExp= case funExp of
                                 RC.RCFFIFUN (ptrExp, ty) => RC.RCFFIFUN (evalExp ptrExp, revealTy ty)
                               | RC.RCFFIEXTERN _ => funExp},
                    revealTy ty, 
                    loc)
        | RC.RCINDEXOF (string, ty, loc) =>
          RC.RCINDEXOF (string, revealTy ty, loc)
        | RC.RCSWITCH {branches:(RC.constant * rcexp) list, defaultExp:rcexp,
                       expTy:Types.ty, loc:Loc.loc, switchExp:rcexp,
                       resultTy} =>
          RC.RCSWITCH 
            {branches =
             map (fn (con, exp) => (con, evalExp exp)) branches,
             defaultExp = evalExp defaultExp,
             expTy=revealTy expTy, 
             loc=loc, 
             switchExp=evalExp switchExp,
             resultTy=revealTy resultTy
            }
        | RC.RCTAGOF (ty, loc) =>
          RC.RCTAGOF (revealTy ty, loc)
        | RC.RCJOIN {isJoin, ty,args=(arg1,arg2),argTys=(argTy1,argTy2),loc} =>
          RC.RCJOIN
            {ty=revealTy ty,
             args=(evalExp arg1, evalExp arg2),
             argTys=(revealTy argTy1, revealTy argTy2),
             isJoin=isJoin,
             loc=loc
            }
        | RC.RCDYNAMIC {exp,ty,elemTy, coerceTy,loc} =>
          RC.RCDYNAMIC {exp=evalExp exp,
                        ty=revealTy ty,
                        elemTy = revealTy elemTy,
                        coerceTy=revealTy coerceTy,
                        loc=loc}
        | RC.RCDYNAMICIS {exp,ty,elemTy, coerceTy,loc} =>
          RC.RCDYNAMICIS {exp=evalExp exp,
                          ty=revealTy ty,
                          elemTy = revealTy elemTy,
                          coerceTy=revealTy coerceTy,
                          loc=loc}
        | RC.RCDYNAMICNULL {ty, coerceTy,loc} =>
          RC.RCDYNAMICNULL {ty=revealTy ty,
                            coerceTy=revealTy coerceTy,
                            loc=loc}
        | RC.RCDYNAMICTOP {ty, coerceTy,loc} =>
          RC.RCDYNAMICTOP {ty=revealTy ty,
                           coerceTy=revealTy coerceTy,
                           loc=loc}
        | RC.RCDYNAMICVIEW {exp,ty,elemTy, coerceTy,loc} =>
          RC.RCDYNAMICVIEW {exp=evalExp exp,
                            ty=revealTy ty,
                            elemTy = revealTy elemTy,
                            coerceTy=revealTy coerceTy,
                            loc=loc}
        | RC.RCDYNAMICCASE
            {
             groupListTerm, 
             groupListTy, 
             dynamicTerm, 
             dynamicTy, 
             elemTy, 
             ruleBodyTy, 
             loc
            } => 
          RC.RCDYNAMICCASE
            {
             groupListTerm = evalExp groupListTerm, 
             groupListTy = revealTy groupListTy, 
             dynamicTerm = evalExp dynamicTerm, 
             dynamicTy = revealTy dynamicTy, 
             elemTy = revealTy elemTy, 
             ruleBodyTy = revealTy ruleBodyTy, 
             loc = loc
            }
        | RC.RCDYNAMICEXISTTAPP {existInstMap, exp, expTy, instTyList, loc} =>
          RC.RCDYNAMICEXISTTAPP
            {existInstMap = evalExp existInstMap,
             exp = evalExp exp,
             expTy = revealTy expTy,
             instTyList = map revealTy instTyList,
             loc = loc}

  and evalDecl (rcdecl:RC.rcdecl) =
      case rcdecl of
        RC.RCEXD (exnInfo, loc) =>
        RC.RCEXD
          (revealExnInfo exnInfo,
           loc)
      | RC.RCEXNTAGD ({exnInfo, varInfo}, loc) =>
        RC.RCEXNTAGD ({exnInfo=revealExnInfo exnInfo,
                       varInfo=revealVar varInfo},
                      loc)
      | RC.RCEXPORTEXN exnInfo =>
        RC.RCEXPORTEXN (revealExnInfo exnInfo)
      | RC.RCEXPORTVAR {var={path, ty}, exp} =>
        RC.RCEXPORTVAR {var={path=path, ty=revealTy ty}, exp=evalExp exp}
      | RC.RCEXTERNEXN ({path, ty}, provider) =>
        RC.RCEXTERNEXN ({path=path, ty=revealTy ty}, provider)
      | RC.RCBUILTINEXN {path, ty} =>
        RC.RCBUILTINEXN {path=path, ty=revealTy ty}
      | RC.RCEXTERNVAR ({path, ty}, provider) =>
        RC.RCEXTERNVAR ({path=path, ty=revealTy ty}, provider)
      | RC.RCVAL (bind:(RC.varInfo * rcexp), loc) =>
        RC.RCVAL (evalBind bind, loc)
      | RC.RCVALPOLYREC
          (btvEnv,
           recbinds:{exp:rcexp, var:RC.varInfo} list,
           loc) =>
        RC.RCVALPOLYREC 
          (revealBtvEnv btvEnv, 
           map
             (fn {exp, var} =>
                 {var=revealVar var,
                  exp=evalExp exp}
             )
             recbinds,
           loc)
      | RC.RCVALREC (recbinds:{exp:rcexp, var:RC.varInfo} list,loc) =>
        RC.RCVALREC 
          (
           map
             (fn {exp, var} =>
                 {var=revealVar var,
                  exp=evalExp exp}
             )
             recbinds,
           loc)
  and evalBind (var, exp) =
      (revealVar var, evalExp exp)
in
  fun revealTyRcdeclList declList = map evalDecl declList
end
end
