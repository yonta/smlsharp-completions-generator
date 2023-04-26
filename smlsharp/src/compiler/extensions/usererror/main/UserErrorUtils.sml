(**
 * @copyright (C) 2021 SML# Development Team.
 * @author Atsushi Ohori
 *)
structure UserErrorUtils =
struct
  local
    val errorQueue = UserError.createQueue ()
  in
    fun initializeErrorQueue () = UserError.clearQueue errorQueue
    fun getErrorsAndWarnings () = UserError.getErrorsAndWarnings errorQueue
    fun getErrors () = UserError.getErrors errorQueue
    fun isAnyError () = not (UserError.isEmptyErrorQueue errorQueue)
    fun getWarnings () = UserError.getWarnings errorQueue
    val enqueueError = UserError.enqueueError errorQueue
    val enqueueWarning = UserError.enqueueWarning errorQueue
  end

  (**
   * checks duplication in a set of names.
   * @params getName elements loc makeExn
   * @param getName a function to retriev name from an element. It should
   *               return NONE if no name is bound.
   * @param elements a list of element which contain a name in it.
   * @param makeExn a function to construct an exception to be reported,
   *            if duplication found.
   * @return unit
   *)
  fun checkSymbolDuplication' getName elements makeExn =
    let
      fun collectDuplication names duplicates [] = SymbolEnv.listItems duplicates
        | collectDuplication names duplicates (element :: elements) =
          case getName element of
            SOME name =>
              let
                val newDuplicates =
                  case SymbolEnv.find(names, name) of
                    SOME _ => SymbolEnv.insert(duplicates, name, name)
                  | NONE => duplicates
                val newNames = SymbolEnv.insert(names, name, name)
              in collectDuplication newNames newDuplicates elements
              end
          | NONE => collectDuplication names duplicates elements
      val duplicateNames = collectDuplication SymbolEnv.empty SymbolEnv.empty elements
    in
      app (fn name => enqueueError(Symbol.symbolToLoc name, makeExn name)) duplicateNames
    end

  fun checkSymbolDuplication getName elements makeExn =
      checkSymbolDuplication' (SOME o getName) elements makeExn

  fun checkRecordLabelDuplication' getName elements loc makeExn =
    let
      fun collectDuplication names duplicates [] = RecordLabel.Map.listItems duplicates
        | collectDuplication names duplicates (element :: elements) =
          case getName element of
            SOME name =>
              let
                val newDuplicates =
                  case RecordLabel.Map.find(names, name) of
                    SOME _ => RecordLabel.Map.insert(duplicates, name, name)
                  | NONE => duplicates
                val newNames = RecordLabel.Map.insert(names, name, name)
              in collectDuplication newNames newDuplicates elements
              end
          | NONE => collectDuplication names duplicates elements
      val duplicateNames = collectDuplication RecordLabel.Map.empty RecordLabel.Map.empty elements
    in
      app (fn name => enqueueError(loc, makeExn name)) duplicateNames
    end

  fun checkRecordLabelDuplication getName elements loc makeExn =
      checkRecordLabelDuplication' (SOME o getName) elements loc makeExn

end
