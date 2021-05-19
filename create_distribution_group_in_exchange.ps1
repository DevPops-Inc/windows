# create distribution group in Exchange

# prompt user input
Write-Host "`nCreate distribution group in Exchange."
Pause

# declare distroList and orgUnit variables
$distroList = Read-Host -Prompt "`nWhat is name of the new distribution list you would like to create? (Example: devs@vicphan.dev)"
$orgUnit= Read-Host -Prompt "`nWhat is organization unit you would want this new distribution list to be a part of? (Example: developers)"

# define CreateDistroGroup function
function CreateDistroGroup()
{
    New-DistributionGroup -Name $distroList -OrganizationalUnit $orgUnit
    Set-DistributionGroup -Identity $distroList -RequireSenderAuthenticationEnabled $false
}

# call CreateDistroGroup function
CreateDistroGroup
