# activate Windows in PowerShell

# you can run this script with: .\ActivateWindows.ps1 -computerName < computer name > -licenseKey < license key >

[CmdletBinding()]
param 
(
      [string] [Parameter(Mandatory = $False)] $computerName = ""
    , [string] [Parameter(Mandatory = $False)] $licenseKey = ""
)

function GetComputerName([string]$computerName)
{
    if (($computerName -eq $Null) -or ($computerName -eq ""))
    {
        $computerName = Read-Host -Prompt "Please type the computer name and press `"Enter`" key (Example: Dev-PC) or press `"Ctrl`" and `"C`" keys to use the computer name from the environment"
        
        return $computerName
    }
    else 
    {
        $computerName = Get-Content $env:Computername
        return $computerName
    }
}

function GetLicenseKey([string]$licenseKey)
{
    if (($licenseKey -eq $Null) -or ($licenseKey -eq ""))
    {
        $licenseKey = Read-Host -Prompt "Please type the Windows license key (Example: aaaaa-bbbbb-ccccc-ddddd-eeeee) and press `"Enter`" key"

        return $licenseKey
    }
    else
    {
        return $licenseKey
    }
}

function CheckOsForWindows()
{
    Write-Host "`nChecking operating system..."
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green
    }
    else 
    {
        Write-Host "Operating System:" $hostOs
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system.`n"
        break
    }
    Write-Host "Finished checking operating system.`n"
}

function ActivateWindows([string]$computerName, [string]$licenseKey)
{
    Write-Host "`nActivate Windows in PowerShell`n"
    CheckOsForWindows

    $computerName = GetComputerName $computerName
    $licenseKey = GetLicenseKey $licenseKey

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started activating Windows at: " $startDateTime
        
        $service = Get-WmiObject -query "select * from SoftwareLicensingService" -Computername $computerName

        $service.InstallProductKey($licenseKey)
        $service.RefreshLicenseStatus()

        Write-Host ("Windows has been activated on {0} with license key: {1}" -F $computerName, $licenseKey) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished activating Windows at: " $finishedDateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime
        
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch
    {
        Write-Host ("Windows failed to activate on {0} with license key: {1}" -F $computerName, $licenseKey) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

ActivateWindows $computerName $licenseKey
