# get serial number on Windows

$ErrorActionPreference = "Stop"

function CheckOsForWin()
{
    Write-Host "Stared checking operating system at" (Get-Date).DateTime
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

function GetSerialNum()
{
    Write-Host "`nGet serial numbers on Windows.`n"
    CheckOsForWin

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started getting serial number at" $startDateTime.DateTime

        $serialNumber = Get-CimInstance win32_bios | Select-Object -ExpandProperty SerialNumber

        Write-Host "The serial number is:" $serialNumber -ForegroundColor Blue
        Write-Host "Successfully got serial number." -ForegroundColor Green
        
        $finishedDateTime = (Get-Date)
        Write-Host "Finished getting serial number at" $finishedDateTime.DateTime
        
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host "Failed to get serial number."  -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

GetSerialNum
