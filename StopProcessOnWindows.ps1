# stop process on Windows 

# you can run this script with: .\StopProcessOnWindows.ps1 -processName < process > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $processName = ""
)

function GetProcessName([string]$processName)
{
    $processName = Read-Host -Prompt "Please type the process you would like to stop and press `"Enter`" key (Example: outlook.exe)"

    return $processName
}
else 
{
    return $processName
}

function CheckOsForWindows()
{
    Write-Host "`nChecking operating system..."
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green
    }
    else 
    {
        Write-Host "Operating System:" $hostOs
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system.`n"
        break
    }
    Write-Host "Finished checking operating system.`n"
}

function StopProcess([string]$processName)
{
    Write-Host "`nStop process on Windows.`n"
    CheckOsForWindows

    Write-Host "The processes running on this computer are:"
    Get-Process

    $processName = GetProcessName $processName

    try 
    {
        Stop-Process -processname $processName

        Write-Host ("Successfully stopped {0} process." -F $processName) -ForegroundColor Green

        Get-Process -Name $processName
    }
    catch 
    {
        Write-Host ("Failed to stop {0} process." -F $processName) -Foreground Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

StopProcess $processName
