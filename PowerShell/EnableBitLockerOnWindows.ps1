# enable BitLocker on Windows 

# you can run this script with: .\EnableBitLockerOnWindows.ps1 -driveLetter < drive letter >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $driveLetter = "" # you can set the drive you want to enable BitLocker on here 
)

function CheckOsForWindows()
{
    Write-Host "`nStarted checking operating system at" (Get-Date).DateTime
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
        Write-Host "Sorry but this script only works in Windows." -ForegroundColor Red`

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        break
    }
}

function GetDriveLetter([string]$driveLetter)
{
    if (($driveLetter -eq $Null) -or ($driveLetter -eq ""))
    {
        $driveLetter = Read-Host -Prompt "`nPlease type the drive letter you would like to enable BitLocker on and press `"Enter`" key (Example: C:)"
        
        return $driveLetter
    }
    else
    {
        return $driveLetter
    }
}

function CheckParameters([string]$driveLetter)
{
    Write-Host "`nStarted checking parameter(s) at" (Get-Date).DateTime
    $valid = $True
    
    Write-Host "Parameter(s):"
    Write-Host "----------------------------------------"
    Write-Host ("driveLetter: {0}" -F $driveLetter)
    Write-Host "----------------------------------------"

    if (($driveLetter -eq $Null) -or ($driveLetter -eq ""))
    {
        Write-Host "driveLetter is not set." -ForegroundColor Red
        $valid = $False
    }

    Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime

    if ($valid -eq $True)
    {
        Write-Host "All parameter check(s) passed.`n" -ForegroundColor Green
    }
    else 
    {
        Write-Host "One or more parameters are incorrect, exiting script."  -ForegroundColor Red

        exit -1
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

        Write-Host ("`nSuccessfully enabled BitLocker on drive {0}.`n" -F $driveLetter) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished enabling BitLocker at" $finishedDateTime.DateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host ("`nFailed to enable BitLocker on drive {0}.`n" -F $driveLetter) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

EnableBitLocker $driveLetter
