# set service to automatic startup on Windows 

# run this script with: .\AutostartServiceOnWin.ps1 -serviceName < service name >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $serviceName = "" # you can set the service you wish to autostart here
)

$ErrorActionPreference = "Stop"

function CheckOsForWin()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host "'"
    }
    else 
    {
        Write-Host "Operating System:" $hostOs
        throw "Sorry but this script only works on Windows." 
    }
}

function GetServiceName([string]$serviceName)
{
    if (($serviceName -eq $Null) -or ($serviceName -eq ""))
    {
        $serviceName = Read-Host -Prompt "Please type the service you wish to set to automatic start up and press `"Enter`" key (Example: XboxNetApiSvc)"

        Write-Host ""
        return $serviceName
    }
    else
    {
        return $serviceName
    }
}

function CheckParameters([string]$serviceName)
{
    Write-Host "Start checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-----------------------------------"
    Write-Host ("serviceName: {0}" -F $serviceName)
    Write-Host "-----------------------------------"

    if (($serviceName -eq $Null) -or ($serviceName -or ""))
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
        throw "One or more parameter checks are incorrect."
    }
}

function SetServiceToAutoStart([string]$serviceName)
{
    Write-Host "`nSet service to automatic startup on Windows.`n"
    CheckOsForWin

    Write-Host "Services running on this computer are:"
    Get-Service

    $serviceName = GetServiceName $serviceName
    CheckParameters $serviceName

    try 
    {
        $startDateTime = (Get-Date)
        
        Write-Host "Started setting service to automatic startup at" $startDateTime.DateTime

        Set-Service $serviceName -StartupType Automatic

        Write-Host ("Successfully set {0} to automatically startup." -F $serviceName) -ForegroundColor Green

        Get-Service -Name $serviceName

        $finishedDateTime = (Get-Date)
        
        Write-Host "Finished setting service to automatic startup at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host ("Failed to set {0} to automatically startup." -F $serviceName) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

SetServiceToAutoStart $serviceName
