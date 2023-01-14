# open photo in Paint 3D on Windows

# .\OpenPhotoInPaint3dOnWindows.ps1 -fileLocation "< file location >""

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $fileLocation = "" # you can set the file location here
)

function CheckOsForWindows()
{
    Write-Host "Started Checking operating system at" (Get-Date).DateTime
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

function GetFileLocation([string]$fileLocation)
{
    if (($fileLocation -eq $Null) -or ($fileLocation -eq ""))
    {
        $fileLocation = Read-Host -Prompt "Please type the location of the file you wish to open in Paint 3D and press the `"Enter`" key (Example: C:\Users\$Env:Username\Desktop\dev.jpg)"

        Write-Host ""
        $fileLocation = $ExecutionContext.InvokeCommand.ExpandString($fileLocation)
        return $fileLocation
    }
    else
    {
        return $fileLocation
    }
}

function CheckParameters([string]$fileLocation)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-------------------------------------"
    Write-Host ("fileLocation: {0}" -F $fileLocation)
    Write-Host "-------------------------------------"

    if (($fileLocation -eq $Null) -or ($fileLocation -eq ""))
    {
        Write-Host "fileLocation is not set." -ForegroundColor Red
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
        Write-Host "One or more parameter checks incorrect." -ForegroundColor Red

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""

        break
    }
}

function OpenPhotoInPaint3d([string]$fileLocation)
{
    Write-Host "`nOpen photo in Paint 3D on Windows.`n"
    CheckOsForWindows

    $fileLocation = GetFileLocation $fileLocation
    CheckParameters $fileLocation

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started opening photo in Paint 3D at" $startDateTime.DateTime

        Start-Process -FilePath "mspaint" -ArgumentList """$fileLocation /ForceBootstrapPaint3D"""

        Write-Host ("Successfully opened {0} in Paint 3D." -F $fileLocation) -ForegroundColor Green

        $finishedDateTme = (Get-Date)
        Write-Host "Finished opening photo in Paint 3D at" $finishedDateTme

        $duration = New-TimeSpan $startDateTime $finishedDateTme

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host ("Failed to open {0} in Paint 3D." -F $fileLocation) -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

OpenPhotoInPaint3d $fileLocation
