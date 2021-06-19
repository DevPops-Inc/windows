# change local user's password on Windows

Write-Host "`nChange local user's password on Windows.`n"
Pause

Write-Host "`nHere are the local users on this computer: `n"
Get-LocalUser

$localUser = Read-Host -Prompt "`nWho is the local user you would like to change the password for? (Example: LocalUser)`n"

$newPassword = Read-Host -Prompt "`nWhat is the new password for the local user? (Example: Password123)`n"

Function ChangeLocalUsersPassword() 
{
    Set-LocalUser -Name $localUser -Password (ConvertTo-SecureString -AsPlainText $newPassword -Force)

    Write-Host ("`nThe password for {0} has been changed.`n" -F $localUser)
}

ChangeLocalUsersPassword
