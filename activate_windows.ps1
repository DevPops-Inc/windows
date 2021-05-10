# activate Windows in PowerShell

# prompt user input 
Write-Host "`nActivate Windows in PowerShell"
Pause

# declare computer, key, and service variables variables 
$computer = Get-Content $env:Computername
$key = Read-Host -Prompt "`n What is your Windows key? (Example: aaaaa-bbbbb-ccccc-ddddd-eeeee)`n"
$service = Get-WmiObject -query "select * from SoftwareLicensingService" -Computername $computer

# active Windows 
$service.InstallProductKey($key)
$service.RefreshLicenseStatus()
