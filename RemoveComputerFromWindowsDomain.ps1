# remove computer from domain on Windows 

# you can run this script with: .\RemoveComputerFromWindowsDomain.ps1 -domain < domain name > -adAdmin < Active Directory admin account > 

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $domain = ""
    , [string] [Parameter(Mandatory = $False)] $adAdmin = ""
)

function GetDomain([string]$domain)
{
    if (($domain -eq $Null) -or ($domain -eq ""))
    {
        $domain = Read-Host -Prompt "Please type the domain you wish to remove the computer from and press `"Enter`" key (Example: developers)"

        return $domain
    }
    else
    {
        return $domain
    }
}

function GetAdAdmin([string]$adAdmin)
{
    if (($adAdmin -eq $Null) -or ($adAdmin -eq ""))
    {
        $adAdmin = Read-Host -Prompt "Please type the Active Directory admin account and press `"Enter`" key (Example: ad.admin)"

        return $adAdmin
    }
    else 
    {
        return $adAdmin    
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

function RemoveComputerFromDomain([string]$domain, [string]$adAdmin)
{
    Write-Host "`nRemove computer from Windows domain.`n"
    CheckOsForWindows

    $domain = GetDomain $domain
    $adAdmin = GetAdAdmin $adAdmin

    try 
    {
        Remove-Computer -UnjoinDomaincredential $domain\$adAdmin -PassThru -Verbose -Restart

        Write-Host ("Sucessfully removed computer from {0} domain." -F $domain) -ForegroundColor Green
    }
    catch
    {
        Write-Host ("Failed to remove computer from {0} domain." -F $domain) -ForegroundColor Red
    }
}

RemoveComputerFromDomain $domain $adAdmin
