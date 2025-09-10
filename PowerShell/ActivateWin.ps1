# activate Windows in PowerShell

# run this script as admin: Start-Process PowerShell -Verb RunAs

# you can run this script with: .\ActivateWin.ps1 -computerName < computer name > -licenseKey < license key >

[CmdletBinding()]
param 
(
    [string] [Parameter(Mandatory = $False)] $computerName = "", # you can set the computer name here
    [string] [Parameter(Mandatory = $False)] $licenseKey   = "" # you can set the license key here
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
        Write-Host ""
    }
    else 
    {
        Write-Host "Operating System:" $hostOs
        throw "Sorry but this script only runs on Windows."
    }
}

function GetComputerName([string]$computerName)
{
    if (($computerName -eq $Null) -or ($computerName -eq ""))
    {
        $computerName = Read-Host -Prompt "Please type the computer name and press the `"Enter`" key (Example: Dev-PC) or press the `"Ctrl`" and `"C`" keys to use the computer name from the environment"
        
        Write-Host ""
        return $computerName
    }
    else 
    {
        $computerName = Get-Content $env:Computername
        return $computerName
    }
}

function GetLicenseKey([string]$licenseKey)
{
    if (($licenseKey -eq $Null) -or ($licenseKey -eq ""))
    {
        $licenseKey = Read-Host -Prompt "Please type the Windows license key (Example: aaaaa-bbbbb-ccccc-ddddd-eeeee) and press the `"Enter`" key"

        Write-Host ""
        return $licenseKey
    }
    else
    {
        return $licenseKey
    }
}

function CheckParameters([string]$computerName, [string]$licenseKey)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-------------------------------------"
    Write-Host ("computerName: {0}" -F $computerName)
    Write-Host ("licenseKey  : {0}" -F $licenseKey)
    Write-Host "-------------------------------------"

    if (($computerName -eq $Null) -or ($computerName -eq ""))
    {
        Write-Host "computerName is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($licenseKey -eq $Null) -or ($licenseKey -eq ""))
    {
        Write-Host "licenseKey is not set." -ForegroundColor Red
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
        throw "One or more parameters are incorrect."
    }
}

function ActivateWin([string]$computerName, [string]$licenseKey)
{
    Write-Host "`nActivate Windows in PowerShell`n"
    CheckOsForWin

    $computerName = GetComputerName $computerName
    $licenseKey   = GetLicenseKey $licenseKey
    CheckParameters $computerName $licenseKey

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started activating Windows at: " $startDateTime.DateTime.DateTime
        
        $service = Get-WmiObject -query "select * from SoftwareLicensingService" -Computername $computerName

        $service.InstallProductKey($licenseKey)
        $service.RefreshLicenseStatus()
        
        Write-Host ("Successfully activated Windows on {0} with license key: {1}" -F $computerName, $licenseKey) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished activating Windows at: " $finishedDateTime.DateTime.DateTime
        
        $duration = New-TimeSpan $startDateTime $finishedDateTime
        
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host ("Failed to activate Windows on {0} with license key: {1}" -F $computerName, $licenseKey) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

ActivateWin $computerName $licenseKey
