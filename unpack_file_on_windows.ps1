#!/bin/powershell

# unpack file on Windows 

#declare variables
$SourceFilePath = # Example: 'C:\'
$DestinationPath = # Example: 'C:\'

#unpack zip file
Expand-Archive -LiteralPath $SourceFilePath -DestinationPath $DestinationPath
