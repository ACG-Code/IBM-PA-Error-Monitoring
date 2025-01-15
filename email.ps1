param( 
	[String[]]$emailTo,
	[String]$emailSubject = 'No subject',
	[String]$emailBody = 'No message',
	[String[]]$emailAttach,
	[String]$emailServer = 'mail.planning-analytics.ibmcloud.com',
	[Int32]$emailPort = 587,
	[String]$emailFrom = 'tm1 notify <nice@mail.planning-analytics.ibmcloud.com>'
)

# Configure Transport Layer Security (TLS)
[System.Net.ServicePointManager]::SecurityProtocol = 'TLS12'

# Determine if a file attachment has been specified
if($emailAttach){
	# Send email with attachment
	Send-MailMessage -SmtpServer $emailServer -UseSsl -Port $emailPort -From $emailFrom -To $emailTo -Subject $emailSubject -Body $emailBody -BodyAsHtml -Attachments $emailAttach -Encoding ([System.Text.Encoding]::UTF8)
}else{
	# Send email without attachment
	Send-MailMessage -SmtpServer $emailServer -UseSsl -Port $emailPort -From $emailFrom -To $emailTo -Subject $emailSubject -Body $emailBody -BodyAsHtml -Encoding ([System.Text.Encoding]::UTF8)
}