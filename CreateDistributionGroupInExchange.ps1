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
        $distroList = Read-Host -Prompt "Please type the name of the new distribution list you would like to create and press `"Enter`" key (Example: devs@vicphan.dev)"
        
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
        $orgUnit= Read-Host -Prompt "Please type the organization unit you would want this new distribution list to be a part of and press `"Enter`" key (Example: developers)"
        
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
        Write-Host "Operating System: " (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green
    }
    else 
    {
        Write-Host "Operating System:" $hostOs
        
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
        $startDateTime = (Get-Date)
        Write-Host "Started creating distribution group at: " $startDateTime

        New-DistributionGroup -Name $distroList -OrganizationalUnit $orgUnit
        Set-DistributionGroup -Identity $distroList -RequireSenderAuthenticationEnabled $false
    
        Write-Host ("Succesfully created {0} in Exchange" -F $distroList) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished creating distribution group at: " $finishedDateTime
        
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch
    {
        Write-Host ("Failed to create {0}" -F $distroList) -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

CreateDistroGroupInExchange $distroList $orgUnit
