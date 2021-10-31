# assign member to distribution list on Exchange

# you can run this script with: .\AssignMemberToDistributionListOnExchange.ps1 -email < email > -distroList < distribution list >

[CmdletBinding()]
param
(
    [string] [Parameter(Mandatory = $False)] $email = "", 
    [string] [Parameter(Mandatory = $False)] $distroList = ""
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

function GetEmail([string]$email)
{
    if (($email -eq $Null) -or ($email -eq ""))
    {
        $email = Read-Host -Prompt "Please type the email would you like to assign to the distribution list and press `"Enter`" key (Example: email@domain.com)"

        Write-Host ""
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
        
        Write-Host ""
        return $distroList
    }
    else 
    {
        return $distroList
    }
}

function CheckParameters([string]$email,[string]$distroList)
{
    Write-Host "Started checking parameters at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameters:"
    Write-Host "---------------------------------"
    Write-Host ("email     : {0}" -F $email)
    Write-Host ("distroList: {0}" -F $distroList)
    Write-Host "---------------------------------"

    if (($email -eq $Null) -or ($email -eq ""))
    {
        Write-Host "email is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($distroList -eq $Null) -or ($distroList -eq ""))
    {
        Write-Host "distroList is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter checks passed." -ForegroundColor Green
    }
    else
    {
        Write-Host "One or more parameters are incorrect." -ForegroundColor Red
        break
    }

    Write-Host "Finished checking parameters at" (Get-Date).DateTime
    Write-Host ""
}

function AssignMemberToDistributionGroup([string]$email,[string]$distroList)
{
    Write-Host "`nAssign member to distribution list on Exchange.`n"
    CheckOsForWindows

    $email = GetEmail $email
    $distroList = GetDistroList $distroList
    CheckParameters $email $distroList

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
