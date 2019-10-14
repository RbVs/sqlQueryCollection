--Enable Mailservice in SQL Express 


EXECUTE msdb.dbo.sysmail_add_account_sp
@account_name = 'MailTest',
@description = 'Sent Mail using MSDB',
@email_address = 'vorname.name@mail.de',
@display_name = 'SqlMail',
@username='vorname.name@mail.de',
@password='password',
@mailserver_name = 'server.com'

EXECUTE msdb.dbo.sysmail_add_profile_sp
@profile_name = 'MailTest',
@description = 'Profile used to send mail'

EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
@profile_name = 'MailTest',
@account_name = 'MailTest',
@sequence_number = 1

EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
@profile_name = 'MailTest',
@principal_name = 'public',
@is_default = 1 

SELECT *FROM msdb.dbo.sysmail_account
SELECT *FROM msdb.dbo.sysmail_configuration
SELECT *FROM msdb.dbo.sysmail_principalprofile
SELECT *FROM msdb.dbo.sysmail_profile
SELECT *FROM msdb.dbo.sysmail_profileaccount
SELECT *FROM msdb.dbo.sysmail_profileaccount

sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'Database Mail XPs', 1;
GO
RECONFIGURE
GO

exec msdb.dbo.sp_send_dbmail 
@profile_name = 'MailTest', 
@recipients = 'vorname.name@mail.de', 
@subject = 'Mail from SQL-Express-Server', 
@body = 'Generated by SQL Express!', 
@body_format = 'text'