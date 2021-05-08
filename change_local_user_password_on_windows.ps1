# change local user's password on Windows

# prompt user input 
Write-Host "`nChange local user's password on Windows."
Pause

# declare localUser and newPassword variables 
$localUser = Read-Host -Prompt "`nWho is the local user you would like to change the password for? (Example: LocalUser)`n"
$newPassword = Read-Host -Prompt "`nWhat is the new password for the local user? (Example: Password123)`n"

# change local user's password
Set-LocalUser -Name $localUser -Password (ConvertTo-SecureString -AsPlainText $newPassword -Force)
