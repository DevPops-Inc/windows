# file finder

# you can run this script with: .\FileFinder.ps1 -drive "< drive >" -filename "< filename >" 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $drive    = "", # you can set the drive here
    [string] [Parameter(Mandatory = $False)] $filename = "" # you can set the filename here
)

function CheckOs()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green
    }
    else 
    {
        Write-Host "Operating System:" $hostOs -ForegroundColor Green
    }
    Write-Host "Finished checking operating system at" (Get-Date).DateTime
    Write-Host ""
}

function GetDrive([string]$drive)
{
    if (($drive -eq $Null) -or ($drive -eq ""))
    {
        $drive = Read-Host -Prompt "Please type the drive you think the file is on and press the `"Enter`" key (Example: C:\ on Windows or / on Mac and Linux)"

        Write-Host ""
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
        $filename = Read-Host -Prompt "Please type the filename you're looking for and press the `"Enter`" key (Example: devops)"

        Write-Host ""
        return $filename
    }
    else 
    { 
        return $filename
    }
}

function CheckParameters([string]$drive, [string]$filename)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-----------------------------"
    Write-Host ("drive   : {0}" -F $drive)
    Write-Host ("filename: {0}" -F $filename)
    Write-Host "-----------------------------"

    if (($drive -eq $Null) -or ($drive -eq ""))
    {
        Write-Host "drive is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($filename -eq $Null) -or ($filename -eq ""))
    {
        Write-Host "filename is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter check(s) passed." -ForegroundColor Green
        
        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        throw "One or more parameters are incorrect." 
    }
}

function FileFinder([string]$drive, [string]$filename)
{    
    Write-Host "`nFile finder.`n"
    CheckOs

    $drive    = GetDrive $drive
    $filename = GetFilename $filename
    CheckParameters $drive $filename

    try 
    {
        $startDateTime = (Get-Date)

        Write-Host ("Started finding file `"{0}`" in {1} drive at {2}." -F $filename, $drive, $startDateTime)

        Write-Host "Please wait since this may this a while . . . " -ForegroundColor Blue   
        Get-ChildItem -Path $drive -Name *$filename* -Recurse -Force

        Write-Host ("Successfully searched for file `"{0}`" on {1}" -F $filename, $drive) -ForegroundColor Green

        $finishedDateTime = (Get-Date)        
        
        Write-Host ("Finished finding file `"{0}`" in {1} drive at {2}" -F $filename, $drive, $finishedDateTime)

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host ("Failed searching for file `"{0}`" on {1} drive" -F $filename, $drive) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

FileFinder $drive $filename
