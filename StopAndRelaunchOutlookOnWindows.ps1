# stop and relaunch Outlook on Windows

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $processName = "OUTLOOK"
    , [int]    [Parameter(Mandatory = $False)] $seconds = 5
    , [string] [Parameter(Mandatory = $False)] $applicationName = "outlook.exe"
)

function CheckParameters([string]$processName, [int]$seconds, [string]$applicationName)
{
    Write-Host "`nStarted checking parameters..."
    $valid = $True

    Write-Host "`nParameters:"
    Write-Host "----------------------------------------"
    Write-Host ("processName    : {0}" -F $processName)
    Write-Host ("seconds        : {0}" -F $seconds)
    Write-Host ("applicationName: {0}" -F $applicationName)
    Write-Host "----------------------------------------`n"
    
    if (($processName -eq $Null) -or ($processName -eq ""))
    {
        Write-Host "processName is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($seconds -eq $Null) -or ($seconds -eq ""))
    {
        Write-Host "seconds is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($applicationName -eq $Null) -or ($applicationName -eq ""))
    {
        Write-Host "applicationName is not set." -ForegroundColor Red
        $valid = $False
    }

    Write-Host "Finished checking parameters."

    if ($valid -eq $True)
    {
        Write-Host "All parameters checks passed." -ForegroundColor Green
    }
    else
    {
        Write-Host "One or more parameters are incorrect, exiting script." -ForegroundColor Red
        exit $result
    }
    Write-Host ""
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

function StopAndRelaunchOutlook([string]$processName, [int]$seconds, [string]$applicationName)
{
    Write-Host "`nStop and relaunch Outlook function on Windows.`n"
    CheckParameters $processName $seconds $applicationName
    CheckOsForWindows 

    try 
    {
        Stop-Process -ProcessName $processName
        Start-Sleep -Seconds $seconds
        Start-Process -FilePath $applicationName 

        Write-Host "Successfully stopped and restarted Outlook." -ForegroundColor Green
    }
    catch 
    {
        Write-Host "Failed to stop and restart Outlook" -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

StopAndRelaunchOutlook $processName $seconds $applicationName
