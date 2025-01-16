601,100
602,"ADMIN - Send Email"
562,"NULL"
586,
585,
564,
565,"cJja<z>Uj3>9QtAbZmrXv2lok?:s;ORQJ:vABj1nHaq42uMB@`KbFeN2>nJs^U@0OG\L<ykklt3C>rpz:[ZwR1AU8P4bYG;YypIzHNgghdvD_>>lYF^7_yK[@w[vT02e6s5ul`o6ad4RJENj?RXIgR_]C[Qzh3_ihquS9S07176Vq3iTQE[c@k5w@:[ykqi6h9GCT>R3"
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
568,""""
570,
571,
569,0
592,0
599,1000
560,4
pSendTo
pFilename
pEmailSubject
pEmailBody
561,4
2
2
2
2
590,4
pSendTo,""
pFilename,""
pEmailSubject,""
pEmailBody,""
637,4
pSendTo,"emal send to"
pFilename,"file path and name <optional>"
pEmailSubject,"email subject"
pEmailBody,"email body"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,45

#****Begin: Generated Statements***
#****End: Generated Statements****

# Relative location of the PowerShell script
sScript = '..\Scripts\email.ps1';

# The single quote character (ie the apostrophe character)
sQuote = CHAR( 39 );

# Email Send To
IF (SUBST (pSendTo,1,1) @<> sQuote);
     sEmailTo = sQuote | pSendTo | sQuote;
ELSE;
     sEmailTo = pSendTo;
ENDIF;

# Email Attachment (if file exists) 
sEmailAttach = pFilename;

# Subject of the email
sEmailSubject = sQuote | pEmailSubject | sQuote;

# Email message
sEmailBody = sQuote | pEmailBody | sQuote;



# Build command line
sCommand = 'Powershell ';
sCommand = sCommand | sScript | ' ';
sCommand = sCommand | '-emailTo ' | sEmailTo | ' ';
sCommand = sCommand | '-emailSubject ' | sEmailSubject | ' ';
sCommand = sCommand | '-emailBody ' | sEmailBody | ' ';

# Include the attachment if one has been specified
IF( sEmailAttach @<> '' );
     sCommand = sCommand | '-emailAttach ' | sQuote | sEmailAttach | sQuote | ' ';
ENDIF;

# Do not wait for the command to finish executing, to minimise risk of hanging and locking
nWait = 0;

# Run the PowerShell script
EXECUTECOMMAND (sCommand, nWait);
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,3

#****Begin: Generated Statements***
#****End: Generated Statements****
576,CubeAction=1511DataAction=1503CubeLogChanges=0_ParameterConstraints=e30=
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
