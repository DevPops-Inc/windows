# enable SMB1 and map drive on Windows

# you can run this script with: .\EnableSmb1AndMapDriveOnWindows.ps1 -driveLetter < drive letter > -path < network share path >

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $driveLetter = ""
    , [string] [Parameter(Mandatory = $False)] $path = ""
)

function GetDriveLetter([string]$driveLetter)
{
    if (($driveLetter -eq $Null) -or ($driveLetter -eq ""))
    {
        Write-Host "`nThe drives on this computer are: `n"
        Get-PSDrive

        $driveLetter = Read-Host -Prompt "`nPlease type the drive letter you would like to map the drive to (Example: G)"

        return $driveLetter
    }
    else 
    {
        return $driveLetter    
    }
}

function GetPath([string]$path)
{
    if (($path -eq $Null) -or ($path -eq ""))
    {
        $path = Read-Host -Prompt "`nPlease type the path to the drive (Example: \\networkshare\Scans)"

        return $path
    }
    else 
    {
        return $path
    }
}

function EnableSmb1AndMapDrive([string]$driveLetter, [string]$path)
{
    Write-Host "`nEnable SMB1 and map drive on Windows.`n"

    $driveLetter = GetDriveLetter $driveLetter
    $path = GetPath $path

    try
    {
        Enable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -All

        New-PSDrive -Name "$driveLetter" -PSProvider FileSystem -Root "$path" -Persist
        
        Write-Host ("`nSuccessfully enabled SMB1 and mapped {0} drive with this path: {1}`n" -F $driveLetter, $path) -ForegroundColor Green
        
        Write-Host "`nThe drives on this computer are: `n"
        Get-PSDrive
    }
    catch
    {
        Write-Host ("`nFailed to enable SMB1 and map {0} drive with this path: {1}`n" -F $driveLetter, $path) -ForegroundColor Red
    }
}

EnableSmb1AndMapDrive $driveLetter $path
