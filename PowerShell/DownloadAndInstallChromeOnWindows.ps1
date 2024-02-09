# download and install Chrome on Windows

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $chromeUrl = 'http://dl.google.com/chrome/install/375.126/chrome_installer.exe'
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
        Write-Host "Sorry but this script only runs on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        break
    }
}

function GetChromeUrl([string]$chromeUrl)
{
    if (($chromeUrl -eq $Null) -or ($chromeUrl -eq ""))
    {
        $chromeUrl = Read-Host -Prompt "Please type the Chrome URL and press `"Enter`" key (Example: http://dl.google.com/chrome/install/375.126/chrome_installer.exe)"

        Write-Host ""
        return $chromeUrl
    }
    else 
    {
        return $chromeUrl
    }
}

function CheckParameters([string]$chromeUrl)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "------------------------------"
    Write-Host ("chromeUrl: {0}" -F $chromeUrl)
    Write-Host "------------------------------"

    if (($chromeUrl -eq $Null) -or ($chromeUrl -eq ""))
    {
        Write-Host "chromeUrl is not set." -ForegroundColor Red
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
        Write-Host "One or more parameters are incorrect." -ForegroundColor Red

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
        break
    }

}

function DownloadAndInstallChrome([string]$chromeUrl) 
{
    Write-Host "`nDownload and Install Chrome on Windows.`n"
    CheckOsForWindows

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started downloading and installing Chrome at: " $startDateTime.DateTime

        mkdir -Path $env:temp\chromeinstall -ErrorAction SilentlyContinue | Out-Null
        $Download = Join-Path $env:temp\chromeinstall chrome_installer.exe
        
        Invoke-WebRequest $chromeUrl -OutFile $Download
        
        Invoke-Expression "$Download /silent /install"

        Write-Host "Successfully downloaded and installed Chrome." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished downloading and installing Chrome at: " $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime
        
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $durations.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch 
    {
        Write-Host "Failed to download and install Chrome." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

DownloadAndInstallChrome $chromeUrl
