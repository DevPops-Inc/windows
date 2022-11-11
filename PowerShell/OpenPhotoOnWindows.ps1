# open photo on Windows

# you can run this script with: .\OpenPhotoOnWindows.ps1 -photoLocation < photo location >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $photoLocation= ""
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

function GetPhotoLocation([string]$photoLocation)
{
    if (($photoLocation-eq $Null) -or ($photoLocation-eq ""))
    {
        $photoLocation= Read-Host -Prompt "Please type the location of the photo you wish to open and press `"Enter`" key (Example: C:\Users\adminvictor\Desktop\deltatre 2019.jpg)"

        Write-Host ""
        return $photoLocation
    }
    else
    {
        return $photoLocation
    }
}

function CheckParameters([string]$photoLocation)
{
    Write-Host "Started checking parameters at" (Get-Date).DateTime
    $valid = $true

    Write-Host "Parameters:"
    Write-Host "---------------------------------------"
    Write-Host ("photoLocation: {0}" -F $photoLocation)
    Write-Host "---------------------------------------"

    if (($photoLocation -eq $Null) -or ($photoLocation -eq ""))
    {
        Write-Host "photoLocation is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter checks passed." -ForegroundColor Green
    }
    else 
    {
        Write-Host "One or more parameter checks incorrect, exiting script." -ForegroundColor Red

        exit -1
    }

    Write-Host "Finished checking parameters at" (Get-Date).DateTime
    Write-Host ""
}

function OpenPhoto([string]$photoLocation)
{
    Write-Host "`nOpen photo on Windows.`n"
    CheckOsForWindows

    $photoLocation = GetPhotoLocation $photoLocation
    CheckParameters $photoLocation
    
    if ((Test-Path $photoLocation) -eq $False)
    {
        Write-Host ("{0} is invalid." -F $photoLocation) -ForegroundColor Red
        break
    }
    
    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started opening photo at" $startDateTime

        Start-Process -Path $photoLocation

        Write-Host ("Successfully opened photo: {0}" -F $photoLocation) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished opening photo at" $finishedDateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch
    {
        Write-Host ("Failed to open photo: {0}" -F $photoLocation) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

OpenPhoto $photoLocation
