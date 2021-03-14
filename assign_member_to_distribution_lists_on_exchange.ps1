#!/bin/powershell

# assign member to distribution list on Exchange

# declare variables
$email = Read-Host -Prompt "What email would you like to assign to the distribution list? (Example: email@domain.com)"
$DistributionList = Read-Host -Prompt "What distribution list would you like to add the email to? (Example: group@domain.com)"

# assign member to distribution list
Add-DistributionGroupMember -Identity $DistributionList -Member $email
