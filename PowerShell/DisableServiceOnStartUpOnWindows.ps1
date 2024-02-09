# disable service on startup on Windows

# you can run this script with: .\DisableServiceOnStartUpOnWindows.ps1 -serviceName < service name >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $serviceName = "" # you can set the service you want to disable here
)

function CheckOsForWindows()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
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
        break
    }
}

function GetServiceOnStartUp([string]$serviceName)
{
    if (($serviceName -eq $Null) -or ($serviceName -eq ""))
    {
        Write-Host "Here are services running on this computer: "
        Get-Service 

        $serviceName = Read-Host -Prompt "Please type the service would you like to disable on startup and press `"Enter`" key"

        Get-Service -Name $serviceName        
        Write-Host ""
        return $serviceName
    }
    else
    {
        Write-Host "{0} service will be disabled on startup." -F $serviceName
        Get-Service -Name $serviceName
        Write-Host ""
        return $serviceName
    }
}

function CheckParameters([string]$serviceName)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-----------------------------------"
    Write-Host ("serviceName: {0}" -F $serviceName)
    Write-Host "-----------------------------------"

    if (($serviceName -eq $Null) -or ($serviceName -eq ""))
    {
        Write-Host "serviceName is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter check(s) passed." -ForegroundColor Green

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "One or more parameters are incorrect, exiting script." -ForegroundColor Red

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
        break
    }
}

function DisableServiceOnStartUp([string]$serviceName)
{
    Write-Host "Disable service on startup on Windows."
    CheckOsForWindows

    $serviceName = GetServiceOnStartUp $serviceName
    CheckParameters $serviceName

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started disabling service at" $startDateTime.DateTime

        Set-Service $serviceName -StartupType Disabled

        Write-Host ("Successfully disabled {0} service on startup." -F $serviceName) -ForegroundColor Green

        Get-Service -Name $serviceName

        $finishedDateTime = (Get-Date)
        Write-Host "Finished disabling service at" $finishedDateTime.DateTime
        
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host ("Failed to disable {0} service on startup." -F $serviceName) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Get-Service -Name $serviceName
        Write-Host ""
    }
}

DisableServiceOnStartUp $serviceName
