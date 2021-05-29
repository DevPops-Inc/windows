# start service on Windows 

# prompt user input
Write-Host "`nStart Service on Windows."
Pause

# list servies
Get-Service

# declare serviceName variable
$serviceName = Read-Host -Prompt "`nPlease type the service you wish to start (Example: XboxNetApiSvc): "

# define StartService function
function StartService()
{
    # start service
    Start-Service $serviceName

    # get service status
    Get-Service -Name $serviceName
}

# call StartService function
StartService
