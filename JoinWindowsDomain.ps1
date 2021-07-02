# join Windows domain

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $domainName = ""
    , [string] [Parameter(Mandatory = $False)] $domainAdmin = ""
)

function GetDomainName([string]$domainName)
{
    if (($domainName -eq $Null) -or ($domainName -eq ""))
    {
        $domainName = Read-Host -Prompt "`nPlease type the domain you want this comptuer to join (Example: domain.com)"

        return $domainName
    }
    else
    {
        return $domainName
    }
}

function GetDomainAdmin([string]$domainAdmin)
{
    if (($domainAdmin -eq $Null) -or ($domainAdmin -eq ""))
    {
        $domainAdmin = Read-Host -Prompt "`nPlease type your domain admin account (Example: DomainAdmin)"

        return $domainAdmin
    }
    else
    {
        return $domainAdmin
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

function JoinWindowsDomain([string]$domainName, [string]$domainAdmin)
{
    Write-Host "`nJoin Windows domain.`n"
    CheckOsForWindows

    $domainName = GetDomainName $domainName
    $domainAdmin = GetDomainAdmin $domainAdmin

    try 
    {
        Add-Computer –DomainName $domainName -Credential $domainAdmin -Restart –Force

        Write-Host ("Successfully joined this computer to {0} domain.`n" -F $domainName) -ForegroundColor Green
    }
    catch
    {
        Write-Host ("`nFailed to join this computer to {0} domain.`n" -F $domainName) -ForegroundColor Red
    }
}

JoinWindowsDomain $domainName $domainAdmin
