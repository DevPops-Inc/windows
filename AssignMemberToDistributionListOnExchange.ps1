# assign member to distribution list on Exchange

# you can run this script with: .\AssignMemberToDistributionListOnExchange.ps1 -email < email > -distroList < distribution list >

[CmdletBinding()]
param
(
      [string] [Parameter(Mandatory = $False)] $email = ""
    , [string] [Parameter(Mandatory = $False)] $distroList = ""
)

function GetEmail([string]$email)
{
    if (($email -eq $Null) -or ($email -eq ""))
    {
        $email = Read-Host -Prompt "Please type the email would you like to assign to the distribution list (Example: email@domain.com)"

        return $email
    }
    else 
    {
        return $email
    }
}

function GetDistroList([string]$distroList)
{
    if (($distroList -eq $Null) -or ($distroList -eq ""))
    {
        $distroList = Read-Host -Prompt "Please type the distribution list would you like to add the email to (Example: group@domain.com)"
        
        return $distroList
    }
    else 
    {
        return $distroList
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

function AssignMemberToDistributionGroup([string]$email,[string]$distroList)
{
    Write-Host "`nAssign member to distribution list on Exchange.`n"
    CheckOsForWindows

    $email = GetEmail $email
    $distroList = GetDistroList $distroList

    try
    {
        Add-DistributionGroupMember -Identity $distroList -Member $email
        Get-DistributionGroupMember -Identity $distroList
    
        Write-Host ("{0} has been added to {1}" -F $email, $distroList) -ForegroundColor Green
    }
    catch
    {
        Write-Host ("{0} failed to be added to {1}" -F $email, $distroList) -ForegroundColor Red
    }
}

AssignMemberToDistributionGroup $email $distroList
