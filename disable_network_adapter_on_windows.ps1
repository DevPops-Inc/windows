# disable network adapter on Windows 

# prompt user input
Write-Host "`nDisable network adapter on Windows."
Pause

# get network adapters names and statuses
Get-NetAdapter | Format-Table

# declare networkAdapter variable
$networkAdapter = Read-Host -Prompt "Which network adapter do you want to do disable?`n"

# disable network adapter and get new list 
Disable-NetAdapter -Name $networkAdapter -Confirm:$false
Get-NetAdapter | Format-Table
