# unpack file on Windows 

# prompt user input
Write-Host "`nUnpack file on Windows."
Pause

# declare variables
$sourceFilePath = Read-Host -Prompt "What is the filepath of the file you wish to unpack? (Example: C:\vic.zip)`n"
$destinationPath = Read-Host -Prompt "What is the filepath you want the contents of the file to go? (Example: C:\)`n"

# unpack zip file
Expand-Archive -LiteralPath $sourceFilePath -destinationPath $destinationPath

# change directory to destination and show contents
Set-Location -Path $destinationPath
Get-ChildItem
