(**
 * @copyright (C) 2021 SML# Development Team.
 * @author Atsushi Ohori
 *)
structure AnalyzeSource =
struct
  open AnalyzerTy
  fun analyzeSouce source evalTopEnd topEnv =
      case source of
        Loc.FILE source => 
        (let
           val fileId = InfoMaps.findSourceMap source
               handle x => (print "b2\n";raise x)
           val fileInfo = Dynamic.format fileId
           val _ = Bug.printMessage 
                     ("Analyzing source file: " ^ fileInfo ^ "\n")
           val _ = 
               AnalyzeTopEnv.analyzeTopEnv Analyzers.analyzers evalTopEnd (fileId, topEnv)
           val _ = Bug.printMessage 
                     ("Analyzing source file: " ^ fileInfo ^ "done.\n")
         in
           ()
         end
         handle InfoMaps.SourceMap => ())
      | Loc.INTERACTIVE => ()

  exception Skip
  fun analyzeInterface source evalTopEnd topEnv = 
    case source of
      Loc.FILE (source as (p,f)) => 
      (let
        val fileId = InfoMaps.findSourceMap source
            handle x => (print "b1\n";raise x)
        val _ = if InfoMaps.memberProcessedFiles fileId then raise Skip
                else ()
        val fileInfo = Dynamic.format fileId
        val _ = Bug.printMessage 
                  ("Analyzing interface file " ^ Filename.toString f ^ ":" ^ fileInfo ^ "\n")
        val _ = 
            AnalyzeTopEnv.analyzeTopEnv Analyzers.analyzers evalTopEnd (fileId, topEnv)
        val _ = Bug.printMessage 
                  ("Analyzing interface file: " ^ fileInfo ^ "done.\n")
      in
        ()
      end
      handle InfoMaps.SourceMap => ()
           | Skip => ()
      )
    | _ => ()
end
