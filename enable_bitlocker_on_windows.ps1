# enable BitLocker on Windows 

# prompt user input 
Write-Host "`nEnable BitLocker on Windows.`n"
Pause

# declare drive variable
$drive = Read-Host -Prompt "`nWhich drive would you like to enable BitLocker on? (Example: C:)`n"

# enable BitLocker
Enable-BitLocker -MountPoint "$drive"
