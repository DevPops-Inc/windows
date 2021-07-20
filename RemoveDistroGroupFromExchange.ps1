# remove distribution group in Exchange

# you can run this script with: .\RemoveDistroGroupFromExchange.ps1 -distroGroup < distribution group > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $distroGroup = ""
)

function GetDistroGroup([string]$distroGroup)
{
    if (($distroGroup -eq $Null) -or ($distroGroup -eq ""))
    {
        $distroGroup = Read-Host -Prompt "Please type the distribution group would you like to remove from Exchange (Example: devs@devs.com)"

        return $distroGroup
    }
    else
    {
        return $distroGroup
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

function RemoveDistroGroup([string]$distroGroup)
{
    Write-Host "`nRemove distribution group in Exchange.`n"
    CheckOsForWindows

    $distroGroup = GetDistroGroup $distroGroup

    try
    {
        Remove-DistributionGroup -Identity "$distroGroup"
        
        Write-Host ("Successfully removed {0} from Exchange." -F $distroGroup) -ForegroundColor Green
    }
    catch 
    {
        Write-Host ("Failed to remove {0} from Exchange." -F $distroGroup) -ForegroundColor Red
    }
}

RemoveDistroGroup $distroGroup
