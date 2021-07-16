# file finder on Windows

# you can run this script with: .\FileFinderOnWindows.ps1 -drive < drive > -filename < filename > 

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $drive = ""
    , [string] [Parameter(Mandatory = $False)] $filename = ""
)

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

function GetDrive([string]$drive)
{
    if (($drive -eq $Null) -or ($drive -eq ""))
    {
        $drive = Read-Host -Prompt "Please type the drive you think the file is on and press `"Enter`" key (Example: C:\)"

        return $drive
    }
    else 
    {
        return $drive
    }
}

function GetFilename([string]$filename)
{
    if (($filename -eq $Null) -or ($filename -eq ""))
    {
        $filename = Read-Host -Prompt "`nPlease type the name of the file you're looked for and press `"Enter`" key (Example: devops)"

        return $filename
    }
    else 
    { 
        return $filename
    }
}

function FileFinder([string]$drive, [string]$filename)
{   
    Write-Host "`nFile finder on Windows.`n"
    CheckOsForWindows

    $drive = GetDrive $drive
    $filename = GetFilename $filename

    try 
    {
        Write-Host "File finder starting.`nPlease wait since this may this a while...`n"
        
        Get-ChildItem -Path $drive -Name *$filename* -Recurse -Force

        Write-Host ("Successfully searched for file {0} on {1}" -F $filename, $drive) -ForegroundColor Green
    }
    catch
    {
        Write-Host ("Failed searching for file {0} on {1}" -F $filename, $drive) -ForegroundColor Red
    }
}

FileFinder $drive $filename
