# set service to automatic startup on Windows 

# prompt user input 
Write-Host "`nSet service to automatic startup on Windows."
Pause

# list services
Get-Service

# declare variables 
$serviceName = Read-Host -Prompt "`nPlease type the service you wish to set to automatic start up (Example: XboxNetApiSvc): "

# define SetServiceToAutoStart function
function SetServiceToAutoStart()
{
    # set service to startup automatically
    Set-Service $serviceName -StartupType Automatic

    # get status of service
    Get-Service -Name $serviceName
}

# call SetServiceToAutoStart function
SetServiceToAutoStart
