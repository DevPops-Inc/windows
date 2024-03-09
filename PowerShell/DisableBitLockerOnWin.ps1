# disable BitLocker on Windows

# you can run this script with: .\DisableBitLockerOnWin.ps1 -driveLetter < drive letter >

[CmdletBinding()]
param
(
    [string] [Parameter(Mandatory = $False)] $driveLetter = "" # you can set your drive letter here
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
        throw "Sorry but this script only works in Windows." 
    }
}

function GetDriveLetter([string]$driveLetter)
{
    if(($driveLetter -eq $Null) -or ($driveLetter -eq ""))
    {
        $driveLetter = Read-Host -Prompt "Please type drive would you like to disable BitLocker on and press `"Enter`" key (Example: C:)"

        Write-Host ""
        return $driveLetter
    }
    else 
    {
        return $driveLetter
    }
}

function CheckParameters([string]$driveLetter)
{
    Write-Host "`Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-----------------------------------"
    Write-Host ("driveLetter: {0}" -F $driveLetter)
    Write-Host "-----------------------------------"

    if (($driveLetter -eq $Null) -or ($driveLetter -eq ""))
    {
        Write-Host "driveLetter is not set." -ForegroundColor Red
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
        throw "One or more parameters are incorrect." 
    }
}

function DisableBitLocker([string]$driveLetter)
{
    Write-Host "`nDisable BitLocker on Windows.`n"
    CheckOsForWindows

    $driveLetter = GetDriveLetter $driveLetter
    CheckParameters $driveLetter

    if ((Test-Path $driveLetter -eq $True))
    {
        Write-Host ("Found {0} drive." -F $driveLetter) -ForegroundColor Green
    }
    else 
    {
        Write-Host ("Cannot find {0} drive." -F $driveLetter) -ForegroundColor Red
        break
    }

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started disabling BitLocker at" $startDateTime.DateTime

        Disable-BitLocker -MountPoint "$driveLetter"

        Write-Host ("Successfully disabled BitLocker on {0} drive." -F $driveLetter) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished disabled BitLocker at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host ("Failed to disable BitLocker on {0} drive." -F $driveLetter) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

DisableBitLocker $driveLetter
