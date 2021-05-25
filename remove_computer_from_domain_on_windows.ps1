# remove computer from domain on Windows 

# prompt user input 
Write-Host "`nRemove computer from domain on Windows.`nPlease run this script on the computer you wish to remove from the domain."
Pause

# declare variables
$domain = Read-Host -Prompt "`nWhich domain do you want to remove the computer from? (Example: developers)"
$adAdmin= Read-Host -Prompt "`nPlease type the Active Directory account (Example: ad.admin): "

# remove computer from domain
Remove-Computer -UnjoinDomaincredential $domain\$adAdmin -PassThru -Verbose -Restart
