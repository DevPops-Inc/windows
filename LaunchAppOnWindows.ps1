# launch application on Windows

# you can run this script with: .\LaunchAppOnWindows.ps1 -appName < .exe > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $appName = ""
)

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

function CheckOsForWindows()
{
    Write-Host "`nChecking operating system..."
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "You are running this script on Windows." -ForegroundColor Green
    }
    else 
    {
        Write-Host "Your operating system is:" $hostOs
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system.`n"
        break
    }
    Write-Host "Finished checking operating system.`n"
}

function LaunchApp([string]$appName)
{
    Write-Host "`nLaunch application in Windows.`n"
    CheckOsForWindows

    Write-Host "The applications on this computer are:"
    Get-ChildItem -Path "C:\Program Files*" -Name "*exe" -Recurse -Force

    $appName = GetAppName $appName

    try
    {
        Start-Process -FilePath $appName
        
        Write-Host ("Successfully launched {0} application." -F $appName) -ForegroundColor Green
    }
    catch 
    {
        Write-Host ("Failed to launch {0} application." -F $appName) -ForegroundColor Red
    }
}

LaunchApp $appName
