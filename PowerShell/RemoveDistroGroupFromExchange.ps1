# remove distribution group in Exchange

# you can run this script with: .\RemoveDistroGroupFromExchange.ps1 -distroGroup < distribution group > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $distroGroup = ""
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
        Write-Host "Operating system is:" $hostOs
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        break
    }
}

function GetDistroGroup([string]$distroGroup)
{
    if (($distroGroup -eq $Null) -or ($distroGroup -eq ""))
    {
        $distroGroup = Read-Host -Prompt "Please type the distribution group would you like to remove from Exchange and press `"Enter`" key (Example: devs@devs.com)"

        Write-Host ""
        return $distroGroup
    }
    else
    {
        return $distroGroup
    }
}

function CheckParameters([string]$distroGroup)
{
    Write-Host "Started checking parameters at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameters:"
    Write-Host "-----------------------------------"
    Write-Host ("distroGroup: {0}" -F $distroGroup)
    Write-Host "-----------------------------------"

    if (($distroGroup -eq $Null) -or ($distroGroup -eq ""))
    {
        Write-Host "distroGroup is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter checks passed." -ForegroundColor Green
    }
    else 
    {
        Write-Host "One or more parameter checks are incorrect, exiting script." -ForegroundColor Red

        exit -1
    }

    Write-Host "Finished checking parameters at" (Get-Date).DateTime
    Write-Host ""
}

function RemoveDistroGroup([string]$distroGroup)
{
    Write-Host "`nRemove distribution group in Exchange.`n"
    CheckOsForWindows

    $distroGroup = GetDistroGroup $distroGroup
    CheckParameters $distroGroup

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started removing distribution group at" $startDateTime

        Remove-DistributionGroup -Identity "$distroGroup"
        
        Write-Host ("Successfully removed {0} from Exchange." -F $distroGroup) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished removing distribution group at" $finishedDateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host ("Failed to remove {0} from Exchange." -F $distroGroup) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

RemoveDistroGroup $distroGroup
