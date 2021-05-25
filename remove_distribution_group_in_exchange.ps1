# remove distribution group in Exchange

# prompt user input
Write-Host "`nRemove distribution group in Exchange."
Pause

# declare distroGroup variables
$distroGroup = Read-Host -Prompt "`nWhich distribution group would you like to remove from Exchange."

# remove distribution group
Remove-DistributionGroup -Identity "$distroGroup"
