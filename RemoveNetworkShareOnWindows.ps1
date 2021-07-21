# remove network share on Windows 

# you can run this script with: .\RemoveNetworkShareOnWindows.ps1 -driveLetter < driver letter >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $driveLetter = ""
)

function GetDriveLetter([string]$driveLetter)
{
    if (($driveLetter -eq $Null) -or ($driveLetter -eq ""))
    {
        $driveLetter = Read-Host -Prompt "Please type the letter for the network share you would like to remove and press `"Enter`" key (Example: D)"

        return $driveLetter
    }
    else 
    {
        return $driveLetter
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

function RemoveNetworkShare([string]$driveLetter)
{
    Write-Host "`nRemove network share on Windows.`n"
    CheckOsForWindows

    Write-Host "The drives on this computer are:"
    Get-PSDrive

    $driveLetter = GetDriveLetter $driveLetter

    try 
    {
        Remove-PSDrive -Name $driveLetter

        Write-Host ("Successfully removed {0} drive." -F $driveLetter) -ForegroundColor Green

        Write-Host "The drives on this computer are:"
        Get-PSDrive
    }
    catch 
    {
        Write-Host ("Failed to remove {0} drive." -F $driveLetter) -ForegroundColor Red

        Write-Host "The drives on this computer are:"
        Get-PSDrive
    }
}

RemoveNetworkShare $driveLetter
