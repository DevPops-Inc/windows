# map drive on Windows

# you can run this script with: .\MapDriveOnWindows.ps1 -driveLetter < drive letter > -path < path > 

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $driveLetter = ""
    , [string] [Parameter(Mandatory = $False)] $path = ""
)

function CheckOsForWindows()
{
    Write-Host "Start checking operating system at" (Get-Date).DateTime
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
        $driveLetter = Read-Host -Prompt "Please type the letter would you like to map the drive with and press `"Enter`" key (Example: D)"
        
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
        $path = Read-Host -Prompt "Please type the path of the drive you wish to map and press `"Enter`" key (Example: \\Network\Share)"

        return $path
    }
    else 
    {
        return $path
    }
}

function CheckParameters([string]$driveLetter, [string]$path)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-----------------------------------"
    Write-Host ("driveLetter: {0}" -F $driveLetter)
    Write-Host ("path       : {0}" -F $path)
    Write-Host "-----------------------------------"

    if (($driveLetter -eq $Null) -or ($driveLetter -eq ""))
    {
        Write-Host "driveLetter is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($path -eq $Null) -or ($path -eq ""))
    {
        Write-Host "path is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter check(s) passed." -ForegroundColor Green
    }
    else 
    {
        Write-Host "One or more parameter checks incorrect, exiting script." -ForegroundColor Red

        exit -1
    }

    Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
    Write-Host ""
}

function MapDrive([string]$driveLetter, [string]$path)
{
    Write-Host "`nMap drive on Windows.`n"
    CheckOsForWindows

    $driveLetter = GetDriveLetter $driveLetter
    $path = GetPath $path
    CheckParameters $driveLetter $path
    
    try 
    {
        $startDateTime = (Get-Date)
        Write-Host ("Started mapping {0} drive at {1}" -F $driveLetter, $startDateTime)

        New-PSDrive -Name "$driveLetter" -PSProvider FileSystem -Root "$path" -Persist

        Write-Host ("Successfully mapped {0} drive with path: {1}" -F $driveLetter, $path) -ForegroundColor Green

        Write-Host "The drives on this computer are:"
        Get-PSDrive

        $finishedDateTime = (Get-Date)
        
        Write-Host ("Finished mapping {0} drive at {1}" -F $driveLetter, $finishedDateTime)

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host ("Failed to map {0} drive with path: {1}" -F $driveLetter, $path) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red

        Write-Host "The drives on this computer are: "
        Get-PSDrive
    }
}

MapDrive $driveLetter $path
