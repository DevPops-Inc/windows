# get all applications on Windows

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

function GetAllApps()
{
    Write-Host "`nGet all applications on Windows.`n"
    CheckOsForWin

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started getting all applications on Windows at" $startDateTime.DateTime

        Get-ChildItem -Path "C:\Program Files*" -Name "*exe" -Recurse -Force        
        Write-Host "Successfully got all applications on Windows." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished getting all applications on Windows at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch 
    {
        Write-Host "Failed to get all applications on Windows." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

GetAllApps
