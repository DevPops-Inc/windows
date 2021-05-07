# create standard user on Windows

# prompt user input
Read-Host -Prompt "`nCreate standard user on Windows.`n"
Pause 

# declare StandardUser, Password, and Description variables
$StandardUser = Read-Host -Prompt "`nWhat is the standard user name? (Example: Standard.User)`n"
$Password = Read-Host -Prompt "`nWhat is the password? (Example: Password1234)`n"
$Description = Read-Host -Prompt "`nWhat is the description? (Example: Standard User)`n"

# create new user and set password
New-LocalUser $StandardUser -Password $Password -FullName $StandardUser -Description $Description

# set password for new user to never expire
Set-LocalUser -Name $StandardUser -PasswordNeverExpires 1

# check if new user has been added
Get-LocalUser
