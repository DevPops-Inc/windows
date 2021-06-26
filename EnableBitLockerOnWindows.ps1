# enable BitLocker on Windows 

# you can run this script with: .\EnableBitLockerOnWindows.ps1 -driveLetter < drive letter >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $driveLetter = ""
)

function GetDriveLetter([string]$driveLetter)
{
    if (($driveLetter -eq $Null) -or ($driveLetter -eq ""))
    {
        $driveLetter = Read-Host -Prompt "`nPlease type the drive letter you would like to enable BitLocker on (Example: C:)"
        
        return $driveLetter
    }
    else
    {
        return $driveLetter
    }
}

function EnableBitLocker([string]$driveLetter)
{
    Write-Host "`nEnable BitLocker on Windows.`n"

    $driveLetter = GetDriveLetter $driveLetter

    try
    {
        Enable-BitLocker -MountPoint "$driveLetter"

        Write-Host ("`nSuccessfully enabled BitLocker on drive {0}.`n" -F $driveLetter) -ForegroundColor Green
    }
    catch 
    {
        Write-Host ("`nFailed to enable BitLocker on drive {0}.`n" -F $driveLetter) -ForegroundColor Red
    }
}

EnableBitLocker $driveLetter
