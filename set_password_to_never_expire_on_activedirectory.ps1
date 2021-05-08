# set password to never expire on Active Directory

# prompt user input 
Write-Host "`nSet password to never expire on Active Directory."
Pause

# declare ADUser variable
$ADUser = Read-Host -Prompt "`nWhich user's password do you wish to set to never expire? (Example: AD.User)`n"

# set password for new user to never expire
Set-LocalUser -Name "$ADUser" -PasswordNeverExpires 1
