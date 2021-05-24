# remove computer from domain on Windows 

# prompt user input 
Write-Host "`nRemove computer from domain on Windows."
Pause

# declare variables
$domain = Read-Host -Prompt "`nWhich domain do you want to remove the computer from? (Example: developers)"
$computer= Read-Host -Prompt "`nWhich computer would you like to remove from the domain? (Example: dev123"

# remove computer from domain
Remove-Computer -UnjoinDomaincredential $domain\$computer-PassThru -Verbose -Restart
