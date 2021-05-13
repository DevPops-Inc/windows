# enable network adapter on Windows

# prompt user input
Write-Host "`nEnable network adapter on Windows"

# get network adapters names and statuses
Get-NetAdapter | format-table

# declare adapter variable
$adapter = Read-Host -Prompt "`nWhich network adapter would you like to enable?  (Example: Ethernet)`n"

# enable network adapter
Enable-NetAdapter -Name $adapter -Confirm:$false
