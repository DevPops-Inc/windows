# assign member to distribution list on Exchange

[CmdletBinding()]
param
(
      [string] [Parameter(Mandatory = $False)] $email = ""
    , [string] [Parameter(Mandatory = $False)] $distributionList = ""
)

function GetEmail([string]$email)
{
    if (($email -eq $Null) -or ($email -eq ""))
    {
        $email = Read-Host -Prompt "`nWhat email would you like to assign to the distribution list? (Example: email@domain.com)"
        return $email
    }
    else 
    {
        return $email
    }
}

function GetDistributionList([string]$distributionList)
{
    if (($distributionList -eq $Null) -or ($distributionList -eq ""))
    {
        $distributionList = Read-Host -Prompt "`nWhat distribution list would you like to add the email to? (Example: group@domain.com)"
        return $distributionList
    }
    else 
    {
        return $distributionList
    }
}

function AssignMemberToDistributionGroup()
{
    Write-Host "`nAssign member to distribution list on Exchange.`n"

    GetEmail $email
    GetDistributionList $distributionList

    Add-DistributionGroupMember -Identity $distributionList -Member $email
    Get-DistributionGroupMember -Identity $distributionList

    Write-Host ("`n{0} has been added to {1)`n" -F $email, $distributionList)
}

AssignMemberToDistributionGroup
