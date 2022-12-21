# stop and relaunch Outlook on Windows

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $processName     = "OUTLOOK", 
    [int]    [Parameter(Mandatory = $False)] $seconds         = 5, 
    [string] [Parameter(Mandatory = $False)] $applicationName = "outlook.exe"
)

function CheckOsForWindows()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host "'"
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
        Read-Host -Prompt "Please type the process name and press the `"Enter`" key (Example: OUTLOOK)"

        Write-Host ""
        return $processName
    }
    else 
    {
        return $processName
    }
}

function GetSeconds([int]$seconds)
{
    if (($seconds -eq $Null) -or ($seconds -eq ""))
    {
        Read-Host -Prompt "Please type the number of seconds and press the `"Enter`" key (Example: 5)" 

        Write-Host ""
        return $seconds
    }
    else 
    {
        return $seconds
    }
}

function GetApplicationName([string]$applicationName)
{
    if (($applicationName -eq $Null) -or ($applicationName -eq ""))
    {
        Read-Host -Prompt "Please type the application name and press the `"Enter`" key (Example: outlook.exe)" 

        Write-Host ""
        return $applicationName
    }
    else 
    {
        return $applicationName
    }
}

function CheckParameters([string]$processName, 
                         [int]   $seconds, 
                         [string]$applicationName)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-------------------------------------------"
    Write-Host ("processName    : {0}" -F $processName)
    Write-Host ("seconds        : {0}" -F $seconds)
    Write-Host ("applicationName: {0}" -F $applicationName)
    Write-Host "-------------------------------------------"
    
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

    if ($valid -eq $True)
    {
        Write-Host "All parameters checks passed." -ForegroundColor Green

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
    }
    else
    {
        Write-Host "One or more parameters are incorrect, exiting script." -ForegroundColor Red

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
        
        break
    }
}

function StopAndRelaunchOutlook([string]$processName, 
                                [int]   $seconds, 
                                [string]$applicationName)
{
    Write-Host "`nStop and relaunch Outlook on Windows.`n"
    CheckOsForWindows

    $processName     = GetProcessName $processName
    $seconds         = GetSeconds $seconds
    $applicationName = GetApplicationName $applicationName
    CheckParameters $processName $seconds $applicationName
     
    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started stopping and relaunching Outlook at" $startDateTime.DateTime

        Stop-Process -ProcessName $processName
        Start-Sleep -Seconds $seconds
        Start-Process -FilePath $applicationName 
        Write-Host "Successfully stopped and restarted Outlook." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished stopping and relaunching Outlook at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch 
    {
        Write-Host "Failed to stop and restart Outlook." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

StopAndRelaunchOutlook $processName $seconds $applicationName
