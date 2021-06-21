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
        $computerName = Read-Host -Prompt "`nPlease type the computer name (Example: Dev-PC) or press `"Ctrl`" and `"C`" keys to use the computer name from the environment: "
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
        $licenseKey = Read-Host -Prompt "`n What is your Windows key? (Example: aaaaa-bbbbb-ccccc-ddddd-eeeee)"
        return $licenseKey
    }
    else
    {
        return $licenseKey
    }
}

function ActivateWindows([string]$computerName, [string]$licenseKey)
{
    Write-Host "`nActivate Windows in PowerShell`n"

    $computerName = GetComputerName $computerName
    $licenseKey = GetLicenseKey $licenseKey

    try
    {
        $service = Get-WmiObject -query "select * from SoftwareLicensingService" -Computername $computerName

        $service.InstallProductKey($licenseKey)
        $service.RefreshLicenseStatus()

        Write-Host ("`nWindows has been activated on {0} with license key: {1}.`n" -F $computerName, $licenseKey) -ForegroundColor Green
    }
    catch
    {
        Write-Host ("`nWindows failed to activate on {0} with license key: {1}`n" -F $computerName, $licenseKey) -ForegroundColor Red
    }
}

ActivateWindows $computerName $licenseKey
