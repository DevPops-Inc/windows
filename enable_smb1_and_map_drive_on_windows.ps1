# enable SMB1 and map drive on Windows

# prompt user input
Write-Host "`nEnable SMB1 and map drive on Windows."
Pause

# declare driveLetter and path variables
$driveLetter = Read-Host -Prompt "`nWhich letter would you like to map the drive to? (Example: G)`n"
$path = Read-Host -Prompt "`nWhat is the path to drive? (Example: \\mdw2k1\AdvancementData)`n"

# enable SMB1
Enable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -All

# map drive
New-PSDrive -Name "$driveLetter" -PSProvider FileSystem -Root "$path" -Persist

# get list of drives
Get-PSDrive
