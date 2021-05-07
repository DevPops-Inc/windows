# create local admin on Windows

# prompt user input 
Write-Host "`nCreate local admin on Windows.`n"
Pause

# declare LocalAdmin, Password, and Description variables
$LocalAdmin = Read-Host -Prompt "`nWhat is the admin name? (Example: 'Foo.Bar')`n"
$Password = Read-Host -Prompt "`nWhat is the password? (Example: 'Password1234')`n"
$Description = Read-Host -Prompt "`nWhat is the description? (Example: 'Local Admin')`n"

# create new user and set password
New-LocalUser "$LocalAdmin" -Password $Password -FullName "$LocalAdmin" -Description "$Description"

# add new user as local administrator
Add-LocalGroupMember -Group "Administrators" -Member "$LocalAdmin"

# set password for new user to never expire
Set-LocalUser -Name "$LocalAdmin" -PasswordNeverExpires 1

# check if new user has been added
Get-LocalUser
