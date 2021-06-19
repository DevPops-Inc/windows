# assign member to distribution list on Exchange

Write-Host "`nAssign member to distribution list on Exchange.`n"
Pause

$email = Read-Host -Prompt "`nWhat email would you like to assign to the distribution list? (Example: email@domain.com)`n"

$distributionList = Read-Host -Prompt "`nWhat distribution list would you like to add the email to? (Example: group@domain.com)`n"

Function AssignMemberToDistributionGroup()
{
    Add-DistributionGroupMember -Identity $distributionList -Member $email
    Get-DistributionGroupMember -Identity $distributionList
}

AssignMemberToDistributionGroup
