# join Windows domain

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $domainName  = "", # you can set the domain name here 
    [string] [Parameter(Mandatory = $False)] $domainAdmin = "" # you can set the domain admin here 
)

$ErrorActionPreference = "Stop"

function CheckOsForWin()
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
        throw "Sorry but this script only works on Windows." 
    }
}

function GetDomainName([string]$domainName)
{
    if (($domainName -eq $Null) -or ($domainName -eq ""))
    {
        $domainName = Read-Host -Prompt "Please type the domain you want this comptuer to join and press `"Enter`" key (Example: domain.com)"

        Write-Host ""
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
        $domainAdmin = Read-Host -Prompt "Please type your domain admin account and press `"Enter`" key (Example: DomainAdmin)"

        Write-Host ""
        return $domainAdmin
    }
    else
    {
        return $domainAdmin
    }
}

function CheckParameters([string]$domainName, [string]$domainAdmin)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-----------------------------------"
    Write-Host ("domainName : {0}" -F $domainName)
    Write-Host ("domainAdmin: {0}" -F $domainAdmin)
    Write-Host "-----------------------------------"

    if (($domainName -eq $Null) -or ($domainName -eq ""))
    {
        Write-Host "domainName is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($domainAdmin -eq $Null) -or ($domainAdmin -eq ""))
    {
        Write-Host "domainAdmin is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter check(s) passed." -ForegroundColor Green

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        throw "One or more parameter checks are incorrect, exiting script." 
    }
}

function JoinWindowsDomain([string]$domainName, [string]$domainAdmin)
{
    Write-Host "`nJoin Windows domain.`n"
    CheckOsForWin

    $domainName  = GetDomainName $domainName
    $domainAdmin = GetDomainAdmin $domainAdmin
    CheckParameters $domainName $domainAdmin

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host ("Started joining {0} domain at {1}" -F $domainName, $startDateTime)

        Add-Computer –DomainName $domainName -Credential $domainAdmin -Restart –Force

        Write-Host ("Successfully joined this computer to {0} domain.`n" -F $domainName) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host ("Finished joining {0} domain at {1}" -F $domainName, $finishedDateTime)
        
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host ("Failed to join this computer to {0} domain." -F 
        $domainName) -ForegroundColor Red
        
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

JoinWindowsDomain $domainName $domainAdmin
