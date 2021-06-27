# file finder on Windows

# you can run this script with: .\FileFinderOnWindows.ps1 -filename < filename > -drive < drive > 

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $filename = ""
    , [string] [Parameter(Mandatory = $False)] $drive = ""
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

function GetFilename([string]$filename)
{
    if (($filename -eq $Null) -or ($filename -eq ""))
    {
        $filename = Read-Host -Prompt "`nPlease type the name of the file you're looked for (Example: devops)"

        return $filename
    }
    else 
    { 
        return $filename
    }
}

function GetDrive([string]$drive)
{
    if (($drive -eq $Null) -or ($drive -eq ""))
    {
        $drive = Read-Host -Prompt "Please type the drive you think the file is on (Example: C:\)"

        return $drive
    }
    else 
    {
        return $drive
    }
}

function FileFinder([string]$filename, [string]$drive)
{
    CheckOsForWindows
    
    Write-Host "File finder on Windows."

    $filename = GetFilename $filename
    $drive = GetDrive $drive

    try 
    {
        Write-Host "File finder starting.`nPlease wait since this may this a while...`n"
        
        Get-ChildItem -Path $drive -Name *$filename* -Recurse -Force

        Write-Host ("`nSuccessfully searched for file {0} on {1}`n" -F $filename, $drive) -ForegroundColor Green
    }
    catch
    {
        Write-Host ("`nFailed searching for file {0} on {1}`n" -F $filename, $drive) -ForegroundColor Red
    }
}

FileFinder $filename $drive
