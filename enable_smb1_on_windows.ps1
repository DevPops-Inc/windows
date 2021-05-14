# enable SMB1 on Windows 

# prompt user input 
Write-Host "`nEnable SMB1 on Windows."
Pause 

# enable SMB1
Enable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -All
