# remove user from Active Directoy

# prompt user input
Write-Host "`nRemove user from Active Directory."
Pause

# declare userName variables
$userName = Read-Host -Prompt "`nWhich user would you like to remove from Active Directory? (Example: software.developer)"

# remove user from Active Directory
Remove-ADGroupMember -Identity $userName -force
