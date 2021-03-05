#!/bin/powershell

# create standard user on Windows

# declare variables
$StandardUser = Read-Host -Prompt "What is the standard user name? (Example: Standard.User)"
$Password = Read-Host -Prompt "What is the password? (Example: Password1234)"
$Description = Read-Host -Prompt "What is the description? (Example: Standard User)"

# create new user and set password
New-LocalUser $StandardUser -Password $Password -FullName $StandardUser -Description $Description

# set password for new user to never expire
Set-LocalUser -Name $StandardUser -PasswordNeverExpires 1

# check if new user has been added
Get-LocalUser
