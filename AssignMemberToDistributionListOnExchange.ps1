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
        $email = Read-Host -Prompt "Please type the email would you like to assign to the distribution list and press `"Enter`" key (Example: email@domain.com)"

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
        $distroList = Read-Host -Prompt "Please type the distribution list would you like to add the email to and press `"Enter`" key (Example: group@domain.com)"
        
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
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green
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

function AssignMemberToDistributionGroup([string]$email,[string]$distroList)
{
    Write-Host "`nAssign member to distribution list on Exchange.`n"
    CheckOsForWindows

    $email = GetEmail $email
    $distroList = GetDistroList $distroList

    try
    {
        $startTimeDate = (Get-Date)
        
        Write-Host "Started assignming member to distribution list on Exchange at: " $startTimeDate

        Add-DistributionGroupMember -Identity $distroList -Member $email
        Get-DistributionGroupMember -Identity $distroList
    
        Write-Host ("Successfully added {0} to {1}" -F $email, $distroList) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        
        Write-Host "Finished assign member to distribution list on Exchange at: " $finishedDateTime

        $duration = New-TimeSpan $startTimeDate $finishedDateTime
        
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch
    {
        Write-Host ("Failed to add {0} to {1}" -F $email, $distroList) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

AssignMemberToDistributionGroup $email $distroList
