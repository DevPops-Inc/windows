# disable BitLocker on Windows

# you can run this script with: .\DisableBitLockerOnWindows.ps1 -driveLetter < drive letter >

[CmdletBinding()]
param
(
    [string] [Parameter(Mandatory = $False)] $driveLetter = ""
)

function GetDriveLetter([string]$driveLetter)
{
    if(($driveLetter -eq $Null) -or ($driveLetter -eq ""))
    {
        $driveLetter = Read-Host -Prompt "`nPlease type drive would you like to disable BitLocker on? (Example: C:)"
        return $driveLetter
    }
    else 
    {
        return $driveLetter
    }
}

function DisableBitLocker([string]$driveLetter)
{
    Write-Host "`nDisable BitLocker on Windows.`n"

    $driveLetter = GetDriveLetter $driveLetter

    try
    {
        # disable BitLocker
        Disable-BitLocker -MountPoint "$driveLetter"

        Write-Host ("`nBitLocker has been disabled on {0} drive.`n" -F $driveLetter) -ForegroundColor Green
    }
    catch
    {
        Write-Host ("`nFailed to disable BitLocker on {0} drive.`n" -F $driveLetter) -ForegroundColor Red
    }
}

DisableBitLocker $driveLetter
