# disable service on startup on Windows

# you can run this script with: .\DisableServiceOnStartUpOnWindows.ps1 -serviceName < service name >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $serviceName = ""
)

function GetServiceOnStartUp([string]$serviceName)
{
    if (($serviceName -eq $Null) -or ($serviceName -eq ""))
    {
        Write-Host "`nHere are services running on this computer: "
        Get-Service 

        $serviceName = Read-Host -Prompt "`nPlease type the service would you like to disable on startup"

        Get-Service -Name $serviceName        

        return $serviceName
    }
    else
    {
        Write-Host "`n{0} service will be disabled on startup.`n" -F $serviceName

        Get-Service -Name $serviceName

        return $serviceName
    }
}

function DisableServiceOnStartUp([string]$serviceName)
{
    Write-Host "`nDisable service on startup on Windows.`n"

    $serviceName = GetServiceOnStartUp $serviceName

    try
    {
        # disable service to startup automatically
        Set-Service $serviceName -StartupType Disabled

        Write-Host ("`nSuccessfully disabled {0} service on startup.`n" -F $serviceName) -ForegroundColor Green

        Get-Service -Name $serviceName
    }
    catch
    {
        Write-Host ("`nFailed to disable {0} service on startup.`n" -F $serviceName) -ForegroundColor Red

        Get-Service -Name $serviceName
    }
}

DisableServiceOnStartUp $serviceName
