# IBM-PA-Error-Monitoring
IBM Planning Analytics model Enhancement: Error Monitoring
## Usage:

`powershell.exe -ExecutionPolicy RemoteSigned -File <File> -TargetDir <TargetDir> -OutputFile <OutputFile> -Days <Days> [options]`

### Positional Arguments (required):

  `<File>`        Location of the Error monitoring powershell script.

  `<TargetDir>`      Log directory to be searched.

  `<OutputFile>`    Target destination for result file.

  `<Days>`         Search for error log files generated in the last <Days> days

  ### Options:


`-SkipString1 <SkipString1> `  Skip any file with keyword <SkipString1> in its filename

`-SkipString2 <SkipString2> `  Skip any file with keyword <SkipString2> in its filename

`-SkipString3 <SkipString3> `  Skip any file with keyword <SkipString3> in its filename

`-SkipString4 <SkipString4> `  Skip any file with keyword <SkipString4> in its filename

`-SkipString5 <SkipString5> `  Skip any file with keyword <SkipString5> in its filename
