#!/bin/powershell

# set password to never expire on Active Directory

#declare variables
$ADUser = Read-Host -Prompt "Which user's password do you wish to set to never expire? (Example: AD.User)"

#set password for new user to never expire
Set-LocalUser -Name "$ADUser" -PasswordNeverExpires 1
