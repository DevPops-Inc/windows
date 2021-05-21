# launch application on Windows

# prompt user input
Write-Host "`nLaunch application in Windows"
Pause 

# declare appName variable
$appName = Read-Host -Prompt "`nWhich application would you like launch? (Example: Chrome)"

# launch application
Start-Process -FilePath $appName
