# enable SMB1 and map drive on Windows

# you can run this script with: .\EnableSmb1AndMapDriveOnWindows.ps1 -driveLetter < drive letter > -path < network share path >

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $driveLetter = ""
    , [string] [Parameter(Mandatory = $False)] $path = ""
)

function CheckOsForWindows()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "Operating System:" $hostOs

        Write-Host "Sorry but this script only works in Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
    }
}

function GetDriveLetter([string]$driveLetter)
{
    if (($driveLetter -eq $Null) -or ($driveLetter -eq ""))
    {
        Write-Host "`nThe drives on this computer are: `n"
        Get-PSDrive

        $driveLetter = Read-Host -Prompt "`nPlease type the drive letter you would like to map the drive to and press `"Enter`" key (Example: G)"

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
        $path = Read-Host -Prompt "`nPlease type the path to the drive and press `"Enter`" key (Example: \\networkshare\Scans)"

        return $path
    }
    else 
    {
        return $path
    }
}

function CheckParameters([string]$driveLetter, [string]$path)
{
    Write-Host "`nStarted checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "`nParameter(s):"
    Write-Host "----------------------------------------"
    Write-Host ("driveLetter: {0}" -F $driveLetter)   
    Write-Host ("path       : {0}" -F $path)
    Write-Host "----------------------------------------"

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

    Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime

    if ($valid -eq $True)
    {
        Write-Host "All parameter check(s) passsed.`n" -ForegroundColor Green
    }
    else 
    {
        Write-Host "One or more parameters are incorrect, exiting script." -ForegroundColor Red

        exit -1
    }
}

function EnableSmb1AndMapDrive([string]$driveLetter, [string]$path)
{
    Write-Host "`nEnable SMB1 and map drive on Windows.`n"
    CheckOsForWindows

    $driveLetter = GetDriveLetter $driveLetter
    $path = GetPath $path
    CheckParameters $driveLetter $path

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started enabling SMB1 and mapping drive at" $startDateTime.DateTime

        Enable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -All

        New-PSDrive -Name "$driveLetter" -PSProvider FileSystem -Root "$path" -Persist
        
        Write-Host ("`nSuccessfully enabled SMB1 and mapped {0} drive with this path: {1}`n" -F $driveLetter, $path) -ForegroundColor Green
        
        Write-Host "`nThe drives on this computer are: `n"
        Get-PSDrive

        $finishedDateTime = (Get-Date)
        Write-Host "Finished enabling SMB1 and mapping drive at" $finishedDateTime.DateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch
    {
        Write-Host ("`nFailed to enable SMB1 and map {0} drive with this path: {1}`n" -F $driveLetter, $path) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

EnableSmb1AndMapDrive $driveLetter $path
