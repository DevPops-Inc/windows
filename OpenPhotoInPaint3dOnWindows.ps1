# open photo in Paint 3D on Windows

# .\OpenPhotoInPaint3dOnWindows.ps1 -fileLocation < file location > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $fileLocation = ""
)

function GetFileLocation([string]$fileLocation)
{
    if (($fileLocation -eq $Null) -or ($fileLocation -eq ""))
    {
        $fileLocation = Read-Host -Prompt "Please type the location of the file you wish to open in Paint 3D (Example: C:\Users\adminvictor\Desktop\deltatre 2019.jpg)"

        return $fileLocation
    }
    else
    {
        return $fileLocation
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

function OpenPhotoInPaint3d([string]$fileLocation)
{
    Write-Host "`nOpen photo in Paint 3D on Windows.`n"
    CheckOsForWindows

    $fileLocation = GetFileLocation $fileLocation

    try 
    {
        Start-Process -FilePath "mspaint" -ArgumentList """$fileLocation /ForceBootstrapPaint3D"""

        Write-Host ("Successfully opened {0} in Paint 3D." -F $fileLocation) -ForegroundColor Green
    }
    catch
    {
        Write-Host ("Failed to open {0} in Paint 3D." -F $fileLocation) -ForegroundColor Red
    }
}

OpenPhotoInPaint3d $fileLocation
