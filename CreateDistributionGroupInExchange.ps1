# create distribution group in Exchange

# you can run this script with: .\CreateDistributionGroundInExchange.ps1 -distroList < distribution group > -orgUnit < organizational unit > 

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
        $distroList = Read-Host -Prompt "Please type the name of the new distribution list you would like to create (Example: devs@vicphan.dev)"
        
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
        $orgUnit= Read-Host -Prompt "Please type the organization unit you would want this new distribution list to be a part of (Example: developers)"
        
        return $orgUnit
    }
    else
    {
        return $orgUnit
    }
}

function CheckOsForWindows()
{
    Write-Host "`nChecking operating system..."
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "You are running this script on Windows." -ForegroundColor Green
    }
    else 
    {
        Write-Host "Your operating system is:" $hostOs
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system.`n"
        break
    }
    Write-Host "Finished checking operating system.`n"
}

function CreateDistroGroupInExchange([string]$distroList, [string] $orgUnit)
{
    Write-Host "`nCreate distribution group in Exchange.`n"
    CheckOsForWindows

    $distroList = GetDistroList $distroList
    $orgUnit = GetOrgUnit $orgUnit

    try
    {
        New-DistributionGroup -Name $distroList -OrganizationalUnit $orgUnit
        Set-DistributionGroup -Identity $distroList -RequireSenderAuthenticationEnabled $false
    
        Write-Host ("Succesfully created {0}" -F $distroList) -ForegroundColor Green
    }
    catch
    {
        Write-Host ("Failed to create {0}" -F $distroList) -ForegroundColor Red
    }
}

CreateDistroGroupInExchange $distroList $orgUnit
