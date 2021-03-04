#!/bin/powershell

# file finder on Windows

$Filename = Read-Host -Prompt "What is the name of the file you're looked for? (Example: devops)"
$Drive = Read-Host -Prompt "What drive do you think the file is on? (Example: C:\)"

Write-Host "Please wait since this may this a while."
Get-ChildItem -Path $Drive -Name *$Filename* -Recurse -Force
