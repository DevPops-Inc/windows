# open photo on Windows

# you can run this script with: .\OpenPhotoOnWindows.ps1 -photoLocation < photo location >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $photoLocation= ""
)

function GetPhotoLocation([string]$photoLocation)
{
    if (($photoLocation-eq $Null) -or ($photoLocation-eq ""))
    {
        $photoLocation= Read-Host -Prompt "Please type the location of the photo you wish to open (Example: C:\Users\adminvictor\Desktop\deltatre 2019.jpg)"

        return $photoLocation
    }
    else
    {
        return $photoLocation
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

function OpenPhoto([string]$photoLocation)
{
    Write-Host "`nOpen photo on Windows.`n"
    CheckOsForWindows

    $photoLocation = GetPhotoLocation $photoLocation
    
    if ((Test-Path $photoLocation) -eq $False)
    {
        Write-Host ("{0} is invalid." -F $photoLocation) -ForegroundColor Red
        break
    }
    else 
    {
        try 
        {
            Start-Process -Path $photoLocation
    
            Write-Host ("Successfully opened photo: {0}" -F $photoLocation) -ForegroundColor Green
        }
        catch
        {
            Write-Host ("Failed to open photo: {0}" -F $photoLocation) -ForegroundColor Red

            Write-Host $_ -ForegroundColor Red
            Write-Host $_.ScriptStackTrace -ForegroundColor Red
        }
    }
}

OpenPhoto $photoLocation
