# stop process on Windows 

# run this script as admin: Start-Proess PowerShell -Verb RunAs
# you can run this script with: .\StopProcessOnWin.ps1 -processName '< process > '

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $processName = ""
)

function CheckOsForWin()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green

        Write-Host "Finished checking operating at" (Get-Date).DateTime
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

function GetProcessName([string]$processName)
{
    if (($processName -eq $Null) -or ($processName -eq ""))
    {
        $processName = Read-Host -Prompt "Please type the process you would like to stop and press the `"Enter`" key (Example: outlook.exe)"

        Write-Host ""
        return $processName
    }
    else 
    {
        return $processName
    }
}

function CheckParameters([string]$processName)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-----------------------------------"
    Write-Host ("processName: {0}" -F $processName)
    Write-Host "-----------------------------------"

    if (($processName -eq $Null) -or ($processName -eq ""))
    {
        Write-Host "processName is not set." -ForegroundColor Red
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
        Write-Host "One or more parameter checks are incorrect, exiting script." -ForegroundColor Red
        
        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""

        break
    }
}

function StopProcess([string]$processName)
{
    Write-Host "`nStop process on Windows.`n"
    CheckOsForWin

    Write-Host "The processes running on this computer are:"
    Get-Process | Format-Table -AutoSize

    $processName = GetProcessName $processName
    CheckParameters $processName

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host ("Started stopping {0} at {1}" -F $processName, $startDateTime.DateTime)

        Stop-Process -processname $processName
        Get-Process -Name $processName | Format-Table -AutoSize
        Write-Host ("Successfully stopped {0}" -F $processName) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host ("Finished stopping {0} at {1}" -F $processName, $finishedDateTime.DateTime)

        $duration = New-TimeSpan $startDateTime $finishedDateTime
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
        Write-Host ""
    }
    catch 
    {
        Write-Host ("Failed to stop {0}" -F $processName) -Foreground Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""

        Write-Host "The processes running on this computer are:"
        Get-Process | Format-Table -AutoSize
    }
}

StopProcess $processName
