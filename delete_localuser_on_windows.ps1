# delete local user on Windows 

# prompt user input 
Write-Host "`nDelete local user on Windows."
Pause

# declare localUser variable
$localUser = Read-Host -Prompt "Type the local user you would like to delete (Example: LocalUser)`n"

#delete local user
Remove-LocalUser -Name "$localUser"
