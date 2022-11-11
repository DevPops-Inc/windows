# launch application on Windows

# you can run this script with: .\LaunchAppOnWindows.ps1 -appName < .exe > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $appName = ""
)

function CheckOsForWindows()
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
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        break
    }
}

function GetAppName([string]$appName)
{
    if (($appName -eq $Null) -or ($appName -eq ""))
    {
        $appName = Read-Host -Prompt "`Please type the application would you like launch and press `"Enter`" key (Example: chrome.exe)"

        return $appName
    }
    else
    {
        return $appName
    }
}

function CheckParameters([string]$appName)
{
    Write-Host "Started checking parameters at" (Get-Date).DateTime
    $valid = $True

    Write-Host "`nParameters:"
    Write-Host "---------------------------"
    Write-Host ("appName: {0}" -F $appName)
    Write-Host "---------------------------"

    if (($appName -eq $Null) -or ($appName -eq "")) 
    {
        Write-Host "appName is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter checks passed." -ForegroundColor Green
    }
    else 
    {
        Write-Host "One or more parameter checks incorrect, exiting script." -ForegroundColor Red

        exit -1
    }

    Write-Host "Finished checking parameters at" (Get-Date).DateTime

    Write-Host ""
}

function LaunchApp([string]$appName)
{
    Write-Host "`nLaunch application in Windows.`n"
    CheckOsForWindows

    Write-Host "The applications on this computer are:"
    Get-ChildItem -Path "C:\Program Files*" -Name "*exe" -Recurse -Force

    $appName = GetAppName $appName
    CheckParameters $appName

    try
    {
        $startDateTime = (Get-Date)
        Write-Host ("Started launching {0} application at {1}" -F $appName, $startDateTime)

        if ((Test-Path $appName) -eq $False)
        {
            throw ("{0} does not exist" -F $appName)
        }

        Start-Process -FilePath $appName
        
        Write-Host ("Successfully launched {0} application." -F $appName) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host ("Finished launching {0} application at {1}" -F $appName, $finishedDateTime)
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host ("Failed to launch {0} application." -F $appName) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

LaunchApp $appName
