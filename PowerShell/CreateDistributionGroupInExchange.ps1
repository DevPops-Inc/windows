# create distribution group in Exchange

# you can run this script with: .\CreateDistributionGroundInExchange.ps1 -distroList < distribution group > -orgUnit < organizational unit > 

[CmdletBinding()]
param
(
    [string] [Parameter(Mandatory = $False)] $distroList = "", # you can set the distribution list here
    [string] [Parameter(Mandatory = $False)] $orgUnit    = "" # you can set the organizational unit here
)

function CheckOsForWindows()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "Operating System:" $hostOs
        Write-Host "Sorry but this script only runs on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""

        break
    }
}

function GetDistroList([string]$distroList)
{
    if (($distroList -eq $Null) -or ($distroList -eq ""))
    {
        $distroList = Read-Host -Prompt "Please type the name of the new distribution list you would like to create and press `"Enter`" key (Example: devs@vicphan.dev)"
        
        Write-Host ""
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
        
        Write-Host ""
        return $orgUnit
    }
    else
    {
        return $orgUnit
    }
}

function CheckParameters([string]$distroList, [string]$orgUnit)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "---------------------------------"
    Write-Host ("distroList: {0}" -F $distroList)
    Write-Host ("orgUnit   : {0}" -F $orgUnit)
    Write-Host "---------------------------------"

    if (($distroList -eq $Null) -or ($distroList -eq ""))
    {
        Write-Host "distroList is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($orgUnit -eq $Null) -or ($orgUnit -eq ""))
    {
        Write-Host "orgUnit is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter(s) checks passed." -ForegroundColor -Green

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "One or more parameters are incorrect." -ForegroundColor Red
        
        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
        
        break
    }
}

function CreateDistroGroupInExchange([string]$distroList, [string]$orgUnit)
{
    Write-Host "`nCreate distribution group in Exchange.`n"
    CheckOsForWindows

    $distroList = GetDistroList $distroList
    $orgUnit    = GetOrgUnit $orgUnit
    CheckParameters $distroList $orgUnit

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started creating distribution group at: " $startDateTime.DateTime.DateTime

        New-DistributionGroup -Name $distroList -OrganizationalUnit $orgUnit

        Set-DistributionGroup -Identity $distroList -RequireSenderAuthenticationEnabled $false
    
        Write-Host ("Succesfully created {0} in Exchange." -F $distroList) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished creating distribution group at: " $finishedDateTime.DateTime.DateTime
        
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host ("Failed to create {0}" -F $distroList) -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

CreateDistroGroupInExchange $distroList $orgUnit
