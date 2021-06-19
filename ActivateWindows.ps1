# activate Windows in PowerShell

Write-Host "`nActivate Windows in PowerShell"
Pause

$computer = Get-Content $env:Computername

$key = Read-Host -Prompt "`n What is your Windows key? (Exampel: aaaaa-bbbbb-ccccc-ddddd-eeeee)`n"

$service = Get-WmiObject -query "select * from SoftwareLicensingService" -Computername $computer

function ActivateWindows()
{
    $service.InstallProductKey($key)
    $service.RefreshLicenseStatus()
}

ActivateWindows
