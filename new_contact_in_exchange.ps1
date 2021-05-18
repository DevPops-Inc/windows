# create new contact in Exchange 

# prompt user input
Write-Host "`nCreate new contact in Exchange."
Pause

# declare contactName, externalEmail, and orgUnit variables
$contactName = Read-Host -Prompt "`nPlease type name of the new contact (Example: Joe Smith)"
$externalEmail = Read-Host -Prompt "`nPlease type contact's email (Example: j.smith@contact.com)"
$orgUnit = "`nPlease type organizational unit of contact (Example: vendors)"

# create new contact 
New-MailContact -Name $contactName -ExternalEmailAddress $externalEmail -OrganizationalUnit $orgUnit
