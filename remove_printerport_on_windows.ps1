# remove printer port on Windows

# prompt user input
Write-Host "`nRemove printer port on Windows."
Pause

# declare variables
$ipAddress = Read-Host -Prompt "`nWhat is the IP address of the printer port you wish to remove? (Example: 127:20:1)"

# remove printer port and host address
Remove-PrinterPort -Name $ipAddress -PrinterHostAddress $ipAddress
