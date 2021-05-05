#!/bin/powershell

# assign member to distribution list on Exchange

# prompt user input 
Write-Host "`nAssign member to distribution list on Exchange.`n"
Pause

# declare variables
$email = Read-Host -Prompt "`nWhat email would you like to assign to the distribution list? (Example: email@domain.com)`n"
$DistributionList = Read-Host -Prompt "`nWhat distribution list would you like to add the email to? (Example: group@domain.com)`n"

# assign member to distribution list
Add-DistributionGroupMember -Identity $DistributionList -Member $email
