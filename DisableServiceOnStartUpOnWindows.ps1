# disable service on startup on Windows

# you can run this script with: .\DisableServiceOnStartUpOnWindows.ps1 -serviceName < service name >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $serviceName = ""
)

function CheckOsForWindows()
{
    Write-Host "`nStarted checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_Operating.System).Caption -ForegroundColor Green

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
    }
    else
    {
        Write-Host "Operating System:" $hostOs

        Write-Host "Sorry but this script only works in Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
    }
}

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

function CheckParameters([string]$serviceName)
{
    Write-Host "`nStarted checking parameters at" (Get-Date).DateTime
    $valid = $True

    Write-Host "`nParameters:"
    Write-Host "----------------------------------------"
    Write-Host ("serviceName: {0}" -F $serviceName)
    Write-Host "----------------------------------------"

    if (($serviceName -eq $Null) -or ($serviceName -eq ""))
    {
        Write-Host "serviceName is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter checks passed.`n" -ForegroundColor Green
    }
    else 
    {
        Write-Host "One or more parameters are incorrect, exiting script." -ForegroundColor Red

        exit -1
    }
}

function DisableServiceOnStartUp([string]$serviceName)
{
    Write-Host "`nDisable service on startup on Windows.`n"
    CheckOsForWindows

    $serviceName = GetServiceOnStartUp $serviceName
    CheckParameters $serviceName

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started disabling service at" $startDateTime

        Set-Service $serviceName -StartupType Disabled

        Write-Host ("`nSuccessfully disabled {0} service on startup.`n" -F $serviceName) -ForegroundColor Green

        Get-Service -Name $serviceName

        $finishedDateTime = (Get-Date)
        Write-Host "Finished disabling service at" $finishedDateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch
    {
        Write-Host ("`nFailed to disable {0} service on startup.`n" -F $serviceName) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Get-Service -Name $serviceName
    }
}

DisableServiceOnStartUp $serviceName
