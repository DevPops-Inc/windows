# rename computer on Windows 

# prompt user input
Write-Host "`nRename computer on Windows."
Pause

# declare variables
$newName = Read-Host -Prompt "`nPlease type what you wish the new compter to be (Example: DEV-PC): "

Rename-Computer -NewName "$newName" -DomainCredential Domain01\Admin01 -Restart
