# remove contact from Exchange

# prompt user input
Write-Host "`nRemove contact from Exchange."
Pause

# declare contactName variable
$contactName = Read-Host -Prompt "`nPlease type the contact you wish to remove (Example: software.vendor):"

# remove contact from Exchange
Remove-MailContact -Identity $contactName -force
