# remove computer from domain on Windows 

# haven't tested this script yet

# you can run this script with: .\RemoveComputerFromWindowsDomain.ps1 -domain < domain name > -adAdmin < Active Directory admin account > 

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $domain = "" # you can set the domain here
    , [string] [Parameter(Mandatory = $False)] $adAdmin = "" # you can set the Active Directory admin here
)

function CheckOsForWindows()
{
    Write-Host "Start checking operating system at" (Get-Date).DateTime
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
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""

        break
    }
}

function GetDomain([string]$domain)
{
    if (($domain -eq $Null) -or ($domain -eq ""))
    {
        $domain = Read-Host -Prompt "Please type the domain you wish to remove the computer from and press the `"Enter`" key (Example: developers)"

        Write-Host ""
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
        $adAdmin = Read-Host -Prompt "Please type the Active Directory admin account and press the `"Enter`" key (Example: ad.admin)"

        Write-Host ""
        return $adAdmin
    }
    else 
    {
        return $adAdmin    
    }
}

function CheckParameters([string]$domain, [string]$adAdmin)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "---------------------------"
    Write-Host ("domain : {0}" -F $domain)
    Write-Host ("adAdmin: {0}" -F $adAdmin)
    Write-Host "---------------------------"

    if (($domain -eq $Null) -or ($domain -eq ""))
    {
        Write-Host "domain is not set." -ForegroundColor red
        $valid = $False
    }

    if (($adAdmin -eq $Null) -or ($adAdmin -eq ""))
    {
        Write-Host "adAdmin is not set." -ForegroundColor Red
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
        Write-Host "One or more parameter checks are incorrect." -ForegroundColor red

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""

        break
    }
}

function RemoveComputerFromDomain([string]$domain, [string]$adAdmin)
{
    Write-Host "`nRemove computer from Windows domain.`n"
    CheckOsForWindows

    $domain = GetDomain $domain
    $adAdmin = GetAdAdmin $adAdmin
    CheckParameters $domain $adAdmin

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started removing computer at" $startDateTime.DateTime

        Remove-Computer -UnjoinDomaincredential $domain\$adAdmin -PassThru -Verbose -Restart

        Write-Host ("Sucessfully removed computer from {0} domain." -F $domain) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished removing computer at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host ("Failed to remove computer from {0} domain." -F $domain) -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

RemoveComputerFromDomain $domain $adAdmin
