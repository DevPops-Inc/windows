# enable SMB2 on Windows

# prompt user input 
Write-Host "`nEnable SMB2 on Windows."
Pause

# enable SMB2
Get-SmbServerConfiguration | Select-Object EnableSMB2Protocol
