# map drive on Windows

# prompt user input
Write-Host "`nMap drive on Windows."
Pause

# declare variables
$DriveLetter = Read-Host -Prompt "`nWhat letter would you like to map the drive with? (Example: D)`n"
$PathWay = Read-Host -Prompt "`nWhat is the pathway of the drive you wish to map? (Example: \\Network\Share)`n"

# map drive
New-PSDrive -Name "$DriveLetter" -PSProvider FileSystem -Root "$PathWay" -Persist

# get list of drives
Get-PSDrive
