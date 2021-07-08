# map drive on Windows

# you can run this script with: .\MapDriveOnWindows.ps1 -driveLetter < drive letter > -path < path > 

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $driveLetter = ""
    , [string] [Parameter(Mandatory = $False)] $path = ""
)

function GetDriveLetter([string]$driveLetter)
{
    if (($driveLetter -eq $Null) -or ($driveLetter = ""))
    {
        $driveLetter = Read-Host -Prompt "Please type the letter would you like to map the drive with (Example: D)"
        
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
        $path = Read-Host -Prompt "Please type the path of the drive you wish to map (Example: \\Network\Share)"

        return $path
    }
    else 
    {
        return $path
    }
}

function CheckOsForWindows()
{
    Write-Host "`nChecking operating system..."
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "You are running this script on Windows." -ForegroundColor Green
    }
    else 
    {
        Write-Host "Your operating system is:" $hostOs
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system.`n"
        break
    }
    Write-Host "Finished checking operating system.`n"
}

function MapDrive([string]$driveLetter, [string]$path)
{
    Write-Host "`nMap drive on Windows.`n"
    #CheckOsForWindows

    $driveLetter = GetDriveLetter $driveLetter
    $path = GetPath $path
    
    try 
    {
        New-PSDrive -Name "$driveLetter" -PSProvider FileSystem -Root "$path" -Persist

        Write-Host ("`nSuccessfully mapped {0} drive with  path: {1}" -F $driveLetter, $path) -ForegroundColor Green

        Write-Host "The drives on this computer are: "
        Get-PSDrive
    }
    catch 
    {
        Write-Host ("`nFailed to map {0} drive with path: {1}" -F $driveLetter, $path) -ForegroundColor Red

        Write-Host "The drives on this computer are: "
        Get-PSDrive
    }
}

MapDrive $driveLetter $path
