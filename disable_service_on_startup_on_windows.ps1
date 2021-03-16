#!/bin/powershell

# disable service on startup on Windows

# get list of services
Get-Service 

# declare variables 
$ServiceName = Read-Host -Prompt "What service would you like to disable on startup?"

# set service to startup automatically
Set-Service $ServiceName -StartupType Disabled
