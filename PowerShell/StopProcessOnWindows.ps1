# stop process on Windows 

# you can run this script with: .\StopProcessOnWindows.ps1 -processName '< process > '

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $processName = ""
)

function CheckOsForWindows()
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
    $processName = Read-Host -Prompt "Please type the process you would like to stop and press `"Enter`" key (Example: outlook.exe)"

    Write-Host ""
    return $processName
}
else 
{
    return $processName
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
    }
    else 
    {
        Write-Host "One or more parameter checks are incorrect, exiting script." -ForegroundColor Red

        break
    }

    Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
    Write-Host ""
}

function StopProcess([string]$processName)
{
    Write-Host "`nStop process on Windows.`n"
    CheckOsForWindows

    Write-Host "The processes running on this computer are:"
    Get-Process
    Write-Host ""

    $processName = GetProcessName $processName
    CheckParameters $processName

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started stopping process at" $startDateTime.DateTime

        Stop-Process -processname $processName

        Write-Host ("Successfully stopped {0} process." -F $processName) -ForegroundColor Green

        Get-Process -Name $processName

        $finishedDateTime = (Get-Date)
        Write-Host "Finished stopping process at" $finishedDateTime.DateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host ("Failed to stop {0} process." -F $processName) -Foreground Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

StopProcess $processName
