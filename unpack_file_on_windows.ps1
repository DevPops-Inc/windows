#!/bin/powershell

# unpack file on Windows 

#declare variables
$SourceFilePath = Read-Host -Prompt "Example: C:\vic.zip"
$DestinationPath = Read-Host -Prompt "Example: C:\"

#unpack zip file
Expand-Archive -LiteralPath $SourceFilePath -DestinationPath $DestinationPath
