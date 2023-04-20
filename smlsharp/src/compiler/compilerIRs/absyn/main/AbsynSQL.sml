(* -*- sml -*- *)
(**
 * syntax for the IML.
 *
 * @copyright (C) 2021 SML# Development Team.
 * @author UENO Katsuhiro
 *)
structure AbsynSQL =
struct

  (*% @formatter(Symbol.symbol) Symbol.format_symbol *)
  type symbol = Symbol.symbol

  (*% @formatter(Symbol.longsymbol) Symbol.format_longsymbol *)
  type longsymbol = Symbol.longsymbol

  (*% @formatter(RecordLabel.label) RecordLabel.format_label *)
  type label = RecordLabel.label

  (*% @formatter(Loc.loc) Loc.format_loc *)
  type loc = Loc.loc

  (*% @params(prefix) *)
  datatype ('exp,'a) clause =
      (*% @format(e * loc) prefix +1 "...(" !N0{ e } ")" *)
      EMBED of 'exp * loc
    | (*% @format(a) a *)
      CLAUSE of 'a

  (*% *)
  type table_selector =
      (*% @format({db, label, loc}) "#" db "." label *)
      {db : symbol, label : label, loc : loc}

  (*% *)
  datatype asc_desc =
      (*% @format "asc" *)
      ASC
    | (*% @format "desc" *)
      DESC

  (*% *)
  datatype distinct =
      (*% @format "distinct" *)
      DISTINCT
    | (*% @format "all" *)
      ALL

  (*% @params(x) *)
  datatype op1 =
      (*% @format L5{ x +1 "IS" +d "NULL" } *)
      IS_NULL
    | (*% @format L5{ x +1 "IS" +d "NOT" +d "NULL"} *)
      IS_NOT_NULL
    | (*% @format L5{ x +1 "IS" +d "TRUE" } *)
      IS_TRUE
    | (*% @format L5{ x +1 "IS" +d "NOT" +d "TRUE"} *)
      IS_NOT_TRUE
    | (*% @format L5{ x +1 "IS" +d "FALSE" } *)
      IS_FALSE
    | (*% @format L5{ x +1 "IS" +d "NOT" +d "FALSE"} *)
      IS_NOT_FALSE
    | (*% @format L5{ x +1 "IS" +d "UNKNOWN" } *)
      IS_UNKNOWN
    | (*% @format L5{ x +1 "IS" +d "NOT" +d "UNKNOWN"} *)
      IS_NOT_UNKNOWN
    | (*% @format L4{ "NOT" +1 x } *)
      NOT

  (*% @params(x,y) *)
  datatype op2 =
      (*% @format L3{ x +1 "AND" +d y } *)
      AND
    | (*% @format L2{ x +1 "OR"+d y } *)
      OR

  (*% @formatter(option) TermFormat.formatOptionalOption
   *  @formatter(withDefault) SmlppgUtil.formatOptWithDefault
   *  @formatter(AbsynConst.constant) AbsynConstFormatter.format_constant *)
  datatype 'exp exp =
      (*% @format(exp * loc) "(" !N0{ "..."  exp ")" } *)
      EXP_EMBED of 'exp * loc
    | (*% @format(c * l) c *)
      CONST of AbsynConst.constant * loc
    | (*% @format "NULL" *)
      NULL of loc
    | (*% @format "TRUE" *)
      TRUE of loc
    | (*% @format "FALSE" *)
      FALSE of loc
    | (*% @format(l * loc) "#." l *)
      COLUMN1 of label * loc
    | (*% @format((l1 * l2) * loc) "#" l1 "." l2 *)
      COLUMN2 of (label * label) * loc
    | (*% @format(e q * loc) "EXISTS" "(" q(e) ")" *)
      EXISTS of 'exp query * loc
    | (*% @format(e q * loc) "(" q(e) ")" *)
      EXP_SUBQUERY of 'exp query * loc
    | (*% @format(op1 * e exp * Loc) op1()(exp(e)) *)
      OP1 of op1 * 'exp exp * loc
    | (*% @format(op2 * e1 exp1 * e2 exp2 * loc) op2()(exp1(e1),exp2(e2)) *)
      OP2 of op2 * 'exp exp * 'exp exp * loc
    | (*% @format(id) id *)
      ID of symbol
    | (*% @format(id * loc) id *)
      OPID of longsymbol * loc
    | (*% @format(id) "(" id ")" *)
      PARENID of symbol
    | (*% @format(e exp exps * loc) N8{ 2[ exps(exp(e))(+1) ] } *)
      APP of 'exp exp list * loc
    | (*% @format(e exp exps * loc) "(" !N0{ exps(exp(e))("," +1) ")" } *)
      TUPLE of 'exp exp list * loc

  and 'exp join =
      (*%
       * @format({inner} * e exp)
       * !N0{ "join" +d "(" 2[ +1 "on" +d exp(e) ] ")" }
       *)
      INNER_JOIN of {inner : bool} * 'exp exp
    | (*% @format "cross" +d "join" *)
      CROSS_JOIN
    | (*% @format "natural" +d "join" *)
      NATURAL_JOIN

  and 'exp table =
      (*% @format(t) t *)
      TABLE of table_selector
    | (*% @format(e t * l * loc) L2{ t(e) +1 "as" +d l } *)
      TABLE_AS of 'exp table * label * loc
    | (*% @format(e1 l * e2 j * e3 r * loc) L3{ l(e1) +1 j(e2) +d r(e3) } *)
      TABLE_JOIN of 'exp table * 'exp join * 'exp table * loc
    | (*% @format(e q * loc) "(" !N0{ q(e) } ")" *)
      TABLE_SUBQUERY of 'exp query * loc

  and 'exp from =
      (*% @format(e t l * loc) { "from" 2[ +1 l(t(e))("," +1) ] } *)
      FROM of 'exp table list * loc

  and 'exp whr =
      (*% @format(e exp * loc) { "where" 2[ +1 exp(e) ] } *)
      WHERE of 'exp exp * loc

  and 'exp groupby =
      (*%
       * @format((e1 exp1 l * loc) * e2 h opt)
       * !N0{ "group" +d "by" 2[ +1 l(exp1(e1))("," +1) ] }
       * opt(h(e2))(+1,)
       *)
      GROUP_BY of ('exp exp list * loc) * 'exp having option

  and 'exp having =
      (*%
       * @format(e exp * loc)
       * !N0{ "having" 2[ +1 exp(e) ] }
       *)
      HAVING of 'exp exp * loc

  and 'exp orderby =
      (*%
       * @format(key l * loc)
       * { "order" +d "by" 2[ +1 l(key)("," +1) ] }
       * @format:key(e exp * a opt) exp(e) opt(a)(+1,)
       *)
      ORDER_BY of ('exp exp * asc_desc option) list * loc

  and 'exp limit =
      (*%
       * @format({limit, offset : offset opt, loc})
       * limit opt(offset)(+1,)
       * @format:limit(e exp opt * loc)
       * !N0{ "limit" +d opt:withDefault(exp(e))("all") }
       * @format:offset(e exp * loc)
       * !N0{ "offset" +d exp(e) }
       *)
      LIMIT of {limit : 'exp exp option * loc,
                offset : ('exp exp * loc) option,
                loc : loc}

  and 'exp offset =
      (*%
       * @format({offset, fetch : fetch opt, loc})
       * offset opt(fetch)(+1,)
       * @format:offset(e exp * rows * loc)
       * !N0{ "offset" +d exp(e) +d rows }
       * @format:fetch(first * e exp opt * rows * loc)
       * !N0{ "fetch" +d first 2[ +1 opt(exp(e))(,+1) ] rows +d "only" }
       *)
      OFFSET of {offset : 'exp exp * string * loc,
                 fetch : (string * 'exp exp option * string * loc) option,
                 loc : loc}

  and 'exp limit_or_offset =
      (*% @format((e,e t) c) c(e,t(e))("limit") *)
      LIMIT_CLAUSE of ('exp, 'exp limit) clause
    | (*% @format((e,e t) c) c(e,t(e))("offset") *)
      OFFSET_CLAUSE of ('exp, 'exp offset) clause

  and 'exp select =
      (*%
       * @format(distinct opt * (field l * loc) * loc2)
       * { "select" opt(distinct)(+d,) 2[ +1 l(field)("," +1) ] }
       * @format:field(l opt * e exp)
       * { exp(e) opt(l)(+1 "as" +d,) }
       *)
      SELECT of distinct option * ((label option * 'exp exp) list * loc) * loc

  and 'exp query =
      (*%
       * @format((e1, q1 select) c1
       *         * (e2, q2 from) c2
       *         * (e3, q3 whr) c3 o3
       *         * e4 groupby o4
       *         * (e5, q5 orderby) c5 o5
       *         * e6 limit o6
       *         * loc)
       * { c1(e1,select(q1))("select")
       *   +1 c2(e2,from(q2))("from")
       *   o3(c3(e3,whr(q3))("where"))(+1,)
       *   o4(groupby(e4))(+1,)
       *   o5(c5(e5,orderby(q5))("order" +d "by"))(+1,)
       *   o6(limit(e6))(+1,) }
       *)
      QUERY of ('exp, 'exp select) clause
                * ('exp, 'exp from) clause
                * ('exp, 'exp whr) clause option
                * 'exp groupby option
                * ('exp, 'exp orderby) clause option
                * 'exp limit_or_offset option
                * loc
    | (*% @format(exp * loc) "select" 2[ +1 "..." "(" !N0 { exp } ")" ] *)
      QUERY_EMBED of 'exp * loc

  (*% @formatter(default) SmlppgUtil.formatOptWithDefault *)
  datatype 'exp insert_values =
      (*%
       * @format(row l) { "values" 2[ +1 l(row)("," +1) ] }
       * @format:row(value l * loc) "(" !N0{ l(value)("," +1) } ")"
       * @format:value(e exp opt * loc) opt:default(exp(e))("default")
       *)
      INSERT_VALUES of (('exp exp option * loc) list * loc) list
    | (*% @format(id * loc) { "values" 2[ id ] } *)
      INSERT_VAR of longsymbol * loc
    | (*% @format(e q) q(e) *)
      INSERT_SELECT of 'exp query

  (*% @formatter(option) TermFormat.formatOptionalOption *)
  datatype 'exp sql =
      (*% @format(e exp) exp(e) *)
      EXP of 'exp exp
    | (*% @format(e f) f(e) *)
      QRY of 'exp query
    | (*% @format(e f) f(e) *)
      SEL of 'exp select
    | (*% @format(e f) f(e) *)
      FRM of 'exp from
    | (*% @format(e f) f(e) *)
      WHR of 'exp whr
    | (*% @format(e f) f(e) *)
      ORD of 'exp orderby
    | (*% @format(e f) f(e) *)
      OFF of 'exp offset
    | (*% @format(e f) f(e) *)
      LMT of 'exp limit
    | (*%
       * @format(t * (lab l * loc) * e v)
       * { "insert" +d "into" +d t +d "(" !N0{ l(lab)("," +1) } ")" +1 v(e) }
       *)
      INSERT_LABELED of table_selector * (label list * loc) * 'exp insert_values
    | (*%
       * @format(t * e q)
       * { "insert" +d "into" +d t +1 q(e) }
       *)
      INSERT_NOLABEL of table_selector * 'exp query
    | (*%
       * @format(t * (field l * loc) * (e1, e2 w) c opt)
       * { "update" +d t
       *   +1 "set" { +1 l(field)("," +1) }
       *   opt(c(e1,w(e2))("where"))(+1,) }
       * @format:field(lab * e exp) { lab +d "=" 2[ +1 exp(e) ] }
       *)
      UPDATE of table_selector * ((label * 'exp exp) list * loc)
                * ('exp, 'exp whr) clause option
    | (*%
       * @format(t * (e1, e2 w) c opt)
       * { "delete" +d "from" +d t opt(c(e1, w(e2))("where"))(+1,) }
       *)
      DELETE of table_selector * ('exp, 'exp whr) clause option
    | (*% @format "begin" *)
      BEGIN
    | (*% @format "commit" *)
      COMMIT
    | (*% @format "rollback" *)
      ROLLBACK
    | (*%
       * @format((e1, e2) c l)
       * "(" !N0{ l(c(e1,e2)())(";" +1) } ")"
       * @format:e2(e s * l) s(e)
       *)
      SEQ of ('exp, 'exp sql * loc) clause list

  (*% @formatter(option) TermFormat.formatOptionalOption *)
  datatype ('exp, 'pat, 'ty) sqlexp =
      (*% @format(e opt * t) L2{ "_sqlserver" opt(e)(+d,) +1 ":" t } *)
      SQLSERVER of 'exp option * 'ty
    | (*% @format(e q) q(e) *)
      SQL of 'exp sql
    | (*%
       * @format(pat * e q)
       * R8{ "_sql" +d pat +d "=>" 2[ +1 q(e) ] }
       *)
      SQLFN of 'pat * 'exp sql

end
