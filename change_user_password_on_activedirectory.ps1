# change user password on Active Directory

# prompt user input
Write-Host "`nChange user password on Active Directory."
Pause

# declare userName and newPassword variables
$userName = Read-Host -Prompt "`nWhat is the username you would like to password for (Example: ADUser)`n"
$newPassword = Read-Host -Prompt "`nWhat is the new password? (Example: Password123)`n"

# change password on Active Directory
Set-ADAccountPassword -Identity $userName -NewPassword (ConvertTo-SecureString -AsPlainText $newPassword -Force)
