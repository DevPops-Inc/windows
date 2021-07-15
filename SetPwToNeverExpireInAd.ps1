# set password to never expire in Active Directory

# you can run this script with: .\SetPwToNeverExpireInAd.ps1 -adUser < username >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $adUser = ""
)

function GetAdUser([string]$adUser)
{
    if (($adUser -eq $Null) -or ($adUser -eq ""))
    {
        $adUser = Read-Host -Prompt "Please type the username whose password you wish to never expire and press `"Enter`" key (Example: AD.User)"

        return $adUser
    }
    else
    {
        return $adUser
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

function SetPwToNeverExpireInActiveDirectory([string]$adUser)
{
    Write-Host "`nSet password to never expire on Active Directory.`n"
    CheckOsForWindows

    $adUser = GetAdUser $adUser

    try
    {
        Set-LocalUser -Name "$adUser" -PasswordNeverExpires 1
        
        Write-Host ("Successfully set password to never expire for {0}." -F $adUser) -ForegroundColor Green
    }
    catch
    {
        Write-Host ("Failed to set password to never expire for {0}." -F $adUser) -ForegroundColor Red
    }
}

SetPwToNeverExpireInActiveDirectory $adUser
