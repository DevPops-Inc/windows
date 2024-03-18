# enable BitLocker on Windows 

# you can run this script with: .\EnableBitLockerOnWind.ps1 -driveLetter < drive letter >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $driveLetter = "" # you can set the drive you want to enable BitLocker on here 
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
    if (($driveLetter -eq $Null) -or ($driveLetter -eq ""))
    {
        $driveLetter = Read-Host -Prompt "Please type the drive letter you would like to enable BitLocker on and press `"Enter`" key (Example: C:)"
        
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
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
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

function EnableBitLocker([string]$driveLetter)
{
    Write-Host "`nEnable BitLocker on Windows.`n"
    CheckOsForWindows

    $driveLetter = GetDriveLetter $driveLetter
    CheckParameters $driveLetter

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started enabling BitLocker at" $startDateTime.DateTime

        Enable-BitLocker -MountPoint "$driveLetter"

        Write-Host ("Successfully enabled BitLocker on drive {0}." -F $driveLetter) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished enabling BitLocker at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
        
        Write-Host ""
    }
    catch 
    {
        Write-Host ("Failed to enable BitLocker on drive {0}." -F $driveLetter) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

EnableBitLocker $driveLetter
