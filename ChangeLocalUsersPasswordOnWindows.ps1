# change local user's password on Windows

# run this script with: .\ChangeLocalUsersPasswordOnWindows.ps1 -localUser < local user > -newPassword < new password >

[CmdletBinding()]
param (
      [string][Parameter(Mandatory = $False)] $localUser = ""
    , [string] [Parameter(Mandatory = $False)] $newPassword = ""
)

function GetLocalUser([string]$localUser)
{
    if (($localUser -eq $Null) -or ($localUser -eq ""))
    {
        $localUser = Read-Host -Prompt "Please type the local user you would like to change the password for (Example: LocalUser)"

        return $localUser
    }
    else
    {
        return $localUser
    }
}

function GetNewPassword([string]$newPassword)
{
    if (($newPassword -eq $Null) -or ($newPassword -eq ""))
    {
        $newPassword = Read-Host -Prompt "Please type the new password for the local user (Example: Password123)"

        return $newPassword
    }
    else
    {
        return $newPassword
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

function ChangeLocalUsersPassword([string]$localUser, [string]$newPassword) 
{
    Write-Host "`nChange local user's password on Windows.`n"
    CheckOsForWindows

    Write-Host "`nThe local users on this computer are:"
    Get-LocalUser

    $localUser = GetLocalUser $localUser
    $newPassword = GetNewPassword $newPassword

    try
    {
        Set-LocalUser -Name $localUser -Password (ConvertTo-SecureString -AsPlainText $newPassword -Force)

        Write-Host ("Successfully changed the password for {0}." -F $localUser) -ForegroundColor Green
    }
    catch
    {
        Write-Host ("Failed to change the password for {0}." -F $localUser) -ForegroundColor Red
    }
}

ChangeLocalUsersPassword $localUser $newPassword
