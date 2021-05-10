# disable service on startup on Windows

# prompt user input
Write-Host "`nDisable service on startup on Windows."
Pause 

# get list of services
Get-Service 

# declare variables 
$ServiceName = Read-Host -Prompt "`nWhat service would you like to disable on startup?`n"

# set service to startup automatically
Set-Service $ServiceName -StartupType Disabled
