# set service to automatic startup on Windows 

# run this script with: .\SetSetToAutoStartUpOnWindows.ps1 -serviceName < service name >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $serviceName = ""
)

function CheckOsForWindows()
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
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        break
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
    Write-Host "Start checking parameters at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameters:"
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
        Write-Host "All parameter checks passed." -ForegroundColor Green
    }
    else 
    {
        Write-Host "One or more parameter checks are incorrect, exiting script." -ForegroundColor Red

        exit -1
    }

    Write-Host "Finished checking parameters at" (Get-Date).DateTime
    Write-Host ""
}

function SetServiceToAutoStart([string]$serviceName)
{
    Write-Host "`nSet service to automatic startup on Windows.`n"
    CheckOsForWindows

    Write-Host "Services running on this computer are:"
    Get-Service

    $serviceName = GetServiceName $serviceName
    CheckParameters $serviceName

    try 
    {
        $startDateTime = (Get-Date)
        
        Write-Host "Started setting service to automatic startup at" $startDateTime

        Set-Service $serviceName -StartupType Automatic

        Write-Host ("Successfully set {0} to automatically startup." -F $serviceName) -ForegroundColor Green

        Get-Service -Name $serviceName

        $finishedDateTime = (Get-Date)
        
        Write-Host "Finished setting service to automatic startup at" $finishedDateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch
    {
        Write-Host ("Failed to set {0} to automatically startup." -F $serviceName) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

SetServiceToAutoStart $serviceName
