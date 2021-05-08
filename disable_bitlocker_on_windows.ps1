# disable BitLocker on Windows

# prompt user input
Write-Host "`nDisable BitLocker on Windows."
Pause

# declare driveLetter variable
$driveLetter = Read-Host -Prompt "`nWhich drive would you like to disable BitLocker on? (Example: C:)"

# disable BitLocker
Disable-BitLocker -MountPoint "$driveLetter"
