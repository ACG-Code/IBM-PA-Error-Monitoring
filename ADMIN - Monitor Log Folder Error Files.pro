601,100
602,"ADMIN - Monitor Log Folder Error Files"
562,"CHARACTERDELIMITED"
586,"..\Logs\ErrorFileLogMonitor.txt"
585,"..\Logs\ErrorFileLogMonitor.txt"
564,
565,"pK]uM15_K4hVtw][a4VP[YMn>==\ghN@DqHk0x9CqlDv]aqhq8nr=RQK1hEnV[WHLnFPT4ynrjd91CMICSy>tl:QG7KCuZ\l`5Y\akKn49v@xwhwPO?dq94cAsVeWDzPghFDKz^[mp=VlQh\urspBjALyv=uKqXdB58J<wiO_FL?uFLqPd9U6pVbfBaf48lxpNp\0UFq"
559,1
928,0
593,
594,
595,
597,
598,
596,
800,
801,
566,0
567,","
588,"."
589,","
568,""
570,
571,
569,0
592,0
599,1000
560,6
pDays
PSkip1
pSkip2
pSkip3
pSkip4
pSkip5
561,6
1
2
2
2
2
2
590,6
pDays,0
PSkip1,""
pSkip2,""
pSkip3,""
pSkip4,""
pSkip5,""
637,6
pDays,""
PSkip1,""
pSkip2,""
pSkip3,""
pSkip4,""
pSkip5,""
577,1
vFileContent
578,1
2
579,1
1
580,1
0
581,1
0
582,1
VarType=32ColType=827
603,0
572,57
#
#     Process: ADMIN - Monitor Log Folder Error Files
#     Purpose: To search thrugh server log files to find any process error files generated within the specified time period (default 1 day)  
#



#Constant variables
cDoubleQuotes = CHAR(34);
cBackSlash = CHAR(92);
cComma = CHAR(44);
sBodyMsg = '<b>Error Files Found: </b> <br>';
nErrorFileCount =0;
nFileFound = 0;
sNow = NOW;
sCurrentDate = TimSt(sNow, '\Y-\m-\d');
sTimeStamp = TimSt(sNow, '\Y\m\d\h\i\s');
nCurrentDateSerial = DAYNO(sCurrentDate);

# Relative location of the PowerShell script
sScript = '..\Scripts\FindTM1ErrorsToFile.ps1';

#Relative location of rhe log directory
pLogDirectory =  '..\Logs';
pDestFile =  pLogDirectory | '\ErrorFileLogMonitor_' |  sTimeStamp | '.txt';

#The default search period is the prior and current day
IF(pDays = 0);
     pDays = 1;
ENDIF;


# Determine the serial date for the starting date
nStartDateSerial = nCurrentDateSerial - pDays;

# Convert the beginning serial number back to a date
sBeginDate = TimSt(nStartDateSerial, '\m/\d/\Y');


#Sample command syntax
#.\script.ps1 -TargetDir "C:\Logs" -OutputFile "C:\Output.txt" -Days 2 -SkipString1 "" -SkipString2 "" -SkipString3 "" -SkipString4 "" -SkipString5 ""

#Linux powershell command to execute script
sCmd = 'powershell.exe -ExecutionPolicy RemoteSigned -File '  | cDoubleQuotes | sScript  | cDoubleQuotes | ' -TargetDir ' | cDoubleQuotes | pLogDirectory | cDoubleQuotes| ' -OutputFile ' | cDoubleQuotes | pDestFile | cDoubleQuotes | ' -Days ' |   NUMBERTOSTRING(pDays) | ' -SkipString1 ' | cDoubleQuotes | pSkip1  | cDoubleQuotes | ' -SkipString2 ' | cDoubleQuotes | pSkip2  | cDoubleQuotes | ' -SkipString3 ' | cDoubleQuotes | pSkip3  | cDoubleQuotes | ' -SkipString4 ' | cDoubleQuotes | pSkip4  | cDoubleQuotes | ' -SkipString5 ' | cDoubleQuotes | pSkip5  | cDoubleQuotes;
LOGOUTPUT('INFO', 'Command:' | sCmd);
ExecuteCommand( sCmd,1);


IF(FILEEXISTS(pDestFile) = 1);
    nFileFound = 1;
ELSE;
    processbreak;
ENDIF;

DatasourceType = 'CHARACTERDELIMITED';
DatasourceNameForServer = pDestFile;
DatasourceASCIIHeaderRecord = 0;  
573,1

574,10

#If not found, continue on to epilog
IF(nFileFound = 0);
    processbreak;
ELSE;
    sBodyMsg = sBodyMsg | vFileContent | '<br>' ;
    nErrorFileCount = nErrorFileCount + 1; 
ENDIF;


575,72



#################################################################
#
# Auto-generated Email Notifications
#
#################################################################


sAppName = CELLGETS ('zLookup Parameter','Application Name','Text');
sEnvFile = WILDCARDFILESEARCH ('..\..\..\env_*',' ');
sEnv = SUBST(sEnvFile,5,LONG(sEnvFile)-4);
sPrefix = sAppName | '(' | sEnv |  ')';


sProcessName = GETPROCESSNAME ();
sSendTo = CELLGETS ('zLookup Parameter','Email Send To','Text');


#Formatting body message
sMsg = '<font size="+2"><b>Error Log File Monitoring Results</b></font><br><br>';
sMsg = sMsg | '<b>Instance Name: </b>' |  sAppName | '<br>';
sMsg = sMsg | '<b>Time Period Monitored: </b>' | sBeginDate | ' - '| TimSt(NOW, '\m/\d/\Y ') | '<br>';
sMsg = sMsg | '<b>Error Log Files Detected: </b>' | NUMBERTOSTRING(nErrorFileCount) | '<br><br>';


IF(pSkip1 @= '' & pSkip2 @= '' & pSkip3 @= '' & pSkip4 @= '' & pSkip5 @= '');
    sExclusion = 'NONE <br>';
ENDIF;

IF(pSkip1 @<> '');
     sExclusion =  cDoubleQuotes | pSkip1 | cDoubleQuotes | '<br>';
ENDIF;

IF(pSkip2 @<> '');
     sExclusion =  sExclusion | cDoubleQuotes | pSkip2 | cDoubleQuotes | '<br>';
ENDIF;

IF(pSkip3 @<> '');
     sExclusion =   sExclusion | cDoubleQuotes | pSkip3 | cDoubleQuotes | '<br>';
ENDIF;

IF(pSkip4 @<> '');
     sExclusion =   sExclusion | cDoubleQuotes | pSkip4 | cDoubleQuotes | '<br>';
ENDIF;

IF(pSkip5 @<> '');
     sExclusion =   sExclusion | cDoubleQuotes | pSkip5 | cDoubleQuotes | '<br>';
ENDIF;


sMsg = sMsg | '<b>Process Exclusions: </b> <br>' | sExclusion | '<br>';

#If there were no errors log files found, set email subject
IF(nFileFound = 0);   
    sEmailSubject = 'TM1 ' | sPrefix | ' No Error Log Files Found';
    sBodyMsg = sBodyMsg | ' NONE <br>' ;
ELSE;
    sEmailSubject = '***WARNING*** TM1 ' | sPrefix | ' Error Log Files Detected';    
ENDIF;

#Compiling full email body
sEmailBody = sMsg | sBodyMsg;

#Execute process to send results in an email
EXECUTEPROCESS ('ADMIN - Send Email','pSendTo',sSendTo,'pFilename','','pEmailSubject',sEmailSubject,'pEmailBody',sEmailBody);





576,_ParameterConstraints=e30=
930,0
638,1
804,0
1217,0
900,
901,
902,
938,0
937,
936,
935,
934,
932,0
933,0
903,
906,
929,
907,
908,
904,0
905,0
909,0
911,
912,
913,
914,
915,
916,
917,0
918,1
919,0
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
