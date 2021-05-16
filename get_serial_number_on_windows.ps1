# get serial number on Windows

# prompt user input
Write-Host "`nGet serial numbers on Windows."
Pause

# get serial number 
Get-CimInstance win32_bios | Format-List serialnumber
