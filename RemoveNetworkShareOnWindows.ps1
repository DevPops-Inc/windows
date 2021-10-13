# remove network share on Windows 

# you can run this script with: .\RemoveNetworkShareOnWindows.ps1 -driveLetter < driver letter >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $driveLetter = ""
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
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        break
    }
}

function GetDriveLetter([string]$driveLetter)
{
    if (($driveLetter -eq $Null) -or ($driveLetter -eq ""))
    {
        $driveLetter = Read-Host -Prompt "Please type the letter for the network share you would like to remove and press `"Enter`" key (Example: D)"

        Write-Host""
        return $driveLetter
    }
    else 
    {
        return $driveLetter
    }
}

function CheckParameters([string]$driveLetter)
{
    Write-Host "Started checking parameters at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameters:"
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
        Write-Host "All parameter checks passed." -ForegroundColor Green
    }
    else
    {
        Write-Host "One or more parameter checks are incorrect, exiting script." -ForegroundColor Red

        exit -1
    }

    Write-Host "Finished checking parameters at" (Get-Date).DateTime
    Write-Host ""
}

function RemoveNetworkShare([string]$driveLetter)
{
    Write-Host "`nRemove network share on Windows.`n"
    CheckOsForWindows

    Write-Host "The drives on this computer are:"
    Get-PSDrive

    $driveLetter = GetDriveLetter $driveLetter
    CheckParameters $driveLetter

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started removing network share at" $startDateTime

        Remove-PSDrive -Name $driveLetter

        Write-Host ("Successfully removed {0} drive." -F $driveLetter) -ForegroundColor Green

        Write-Host "The drives on this computer are:"
        Get-PSDrive

        $finishedDateTime = (Get-Date)
        Write-Host "Finished removing network share at" $finishedDateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host ("Failed to remove {0} drive." -F $driveLetter) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red

        Write-Host "The drives on this computer are:"
        Get-PSDrive
    }
}

RemoveNetworkShare $driveLetter
