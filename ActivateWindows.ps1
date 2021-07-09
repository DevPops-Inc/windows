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
        $computerName = Read-Host -Prompt "Please type the computer name (Example: Dev-PC) or press `"Ctrl`" and `"C`" keys to use the computer name from the environment"
        
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
        $licenseKey = Read-Host -Prompt "Please type the Windows key (Example: aaaaa-bbbbb-ccccc-ddddd-eeeee)"

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

function ActivateWindows([string]$computerName, [string]$licenseKey)
{
    Write-Host "`nActivate Windows in PowerShell`n"
    CheckOsForWindows

    $computerName = GetComputerName $computerName
    $licenseKey = GetLicenseKey $licenseKey

    try
    {
        $service = Get-WmiObject -query "select * from SoftwareLicensingService" -Computername $computerName

        $service.InstallProductKey($licenseKey)
        $service.RefreshLicenseStatus()

        Write-Host ("Windows has been activated on {0} with license key: {1}" -F $computerName, $licenseKey) -ForegroundColor Green
    }
    catch
    {
        Write-Host ("Windows failed to activate on {0} with license key: {1}" -F $computerName, $licenseKey) -ForegroundColor Red
    }
}

ActivateWindows $computerName $licenseKey
