# file finder on Windows

# prompt user input
Write-Host "`nFile finder on Windows.`n"
Pause

# declare Filename and Drive variables
$Filename = Read-Host -Prompt "What is the name of the file you're looked for? (Example: devops)"
$Drive = Read-Host -Prompt "What drive do you think the file is on? (Example: C:\)"

# find the file
Write-Host "Please wait since this may this a while."
Get-ChildItem -Path $Drive -Name *$Filename* -Recurse -Force
