# launch application on Windows

# you can run this script with: .\LaunchAppOnWin.ps1 -appName '< .exe >' 

[CmdletBinding()]
param
(
    [string] [Parameter(Mandatory = $False)] $appName = "" # you can set your app here 
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
        throw "Sorry but this script only works on Windows." 
    }
}

function GetAppName([string]$appName)
{
    if (($appName -eq $Null) -or ($appName -eq ""))
    {
        $appName = Read-Host -Prompt "`Please type the application would you like launch and press `"Enter`" key (Example: Google\Chrome\Application\chrome.exe)"

        Write-Host ""
        return $appName
    }
    else
    {
        Write-Host ""
        return $appName
    }
}

function CheckParameters([string]$appName)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
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
        Write-Host "All parameter check(s) passed." -ForegroundColor Green

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        throw "One or more parameter checks incorrect." 
    }
}

function LaunchApp([string]$appName)
{
    Write-Host "`nLaunch application in Windows.`n"
    CheckOsForWin

    Write-Host "The applications on this computer are:"
    Get-ChildItem -Path "C:\Program Files*" -Name "*exe" -Recurse -Force
    Write-Host ""

    $appName = GetAppName $appName
    CheckParameters $appName

    try
    {
        $startDateTime = (Get-Date)
        Write-Host ("Started launching {0} application at {1}" -F $appName, $startDateTime)

        $appPath = Join-Path "C:\Program Files\" $appName

        if ((Test-Path $appPath) -eq $False)
        {
            throw ("{0} does not exist" -F $appName)
        }

        Start-Process -FilePath $appPath
        
        Write-Host ("Successfully launched {0} application." -F $appName) -ForegroundColor Green

        $finishedDateTime = (Get-Date)

        Write-Host ("Finished launching {0} application at {1}" -F $appName, $finishedDateTime)

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch 
    {
        Write-Host ("Failed to launch {0} application." -F $appName) -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

LaunchApp $appName
