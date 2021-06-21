# create distribution group in Exchange

[CmdletBinding()]
param
(
      [string] [Parameter(Mandatory = $False)] $distroList = ""
    , [string] [Parameter(Mandatory = $False)] $orgUnit = ""
)

function GetDistroList([string]$distroList)
{
    if (($distroList -eq $Null) -or ($distroList -eq ""))
    {
        $distroList = Read-Host -Prompt "`nWhat is name of the new distribution list you would like to create? (Example: devs@vicphan.dev)`n"
        return $distroList
    }
    else
    {
        return $distroList
    }
}

function GetOrgUnit([string]$orgUnit)
{
    if (($orgUnit -eq $Null) -or ($orgUnit -eq ""))
    {
        $orgUnit= Read-Host -Prompt "`nWhat is organization unit you would want this new distribution list to be a part of? (Example: developers)"
        return $orgUnit
    }
    else
    {
        return $orgUnit
    }
}

function CreateDistroGroupInExchange([string]$distroList, [string] $orgUnit)
{
    Write-Host "`nCreate distribution group in Exchange."

    GetDistroList $distroList
    GetOrgUnit $orgUnit

    New-DistributionGroup -Name $distroList -OrganizationalUnit $orgUnit
    Set-DistributionGroup -Identity $distroList -RequireSenderAuthenticationEnabled $false

    Write-Host ("`n{0} has been created.`n" -F $distroList)
}

CreateDistroGroupInExchange $distroList $orgUnit
