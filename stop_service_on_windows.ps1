# stop service on Windows

# prompt user input
Write-Host "`nStop service on Windows"
Pause

# get list of services 
Get-Service

# declare serviceName variable
$serviceName = Read-Host -Prompt "`nPlease type service you wish to stop (Example: XboxNetApiSvc): "

# define StopServiceOnWindows function
function StopServiceOnWindows()
{
    # stop service 
    Stop-Service $serviceName

    # get service status
    Get-Service -Name $serviceName
}

# call StopServiceOnWindows function
StopServiceOnWindows
