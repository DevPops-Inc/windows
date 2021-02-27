#!/bin/powershell

# create local admin on Windows

# declare variables
$LocalAdmin = Read-Host -Prompt "What is the admin name? (Example: 'Foo.Bar')"
$Password = Read-Host -Prompt "What is the password? (Example: 'Password1234')"
$Description = Read-Host -Prompt "What is the description? (Example: 'Local Admin')"

# create new user and set password
New-LocalUser "$LocalAdmin" -Password $Password -FullName "$LocalAdmin" -Description "$Description"

# add new user as local administrator
Add-LocalGroupMember -Group "Administrators" -Member "$LocalAdmin"

# set password for new user to never expire
Set-LocalUser -Name "$LocalAdmin" -PasswordNeverExpires 1

# check if new user has been added
Get-LocalUser
