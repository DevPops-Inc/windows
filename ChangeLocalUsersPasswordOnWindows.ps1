# change local user's password on Windows

[CmdletBinding()]
param (
      [string][Parameter(Mandatory = $False)] $localUser = ""
    , [string] [Parameter(Mandatory = $False)] $newPassword = ""
)

function GetLocalUser([string]$localUser)
{
    if (($localUser -eq $Null) -or ($localUser -eq ""))
    {
        $localUser = Read-Host -Prompt "`nWho is the local user you would like to change the password for? (Example: LocalUser)"
        return $localUser
    }
    else
    {
        return $localUser
    }
}

function GetNewPassword($newPassword)
{
    if (($newPassword -eq $Null) -or ($newPassword -eq ""))
    {
        $newPassword = Read-Host -Prompt "`nWhat is the new password for the local user? (Example: Password123)"
        return $newPassword
    }
    else
    {
        return $newPassword
    }
}

function ChangeLocalUsersPassword([string]$localUser, [string]$newPassword) 
{
    Write-Host "`nChange local user's password on Windows.`n"

    Write-Host "`nThe local users on this computer are: `n"
    Get-LocalUser

    GetLocalUser $localUser
    GetNewPassword $newPassword

    Set-LocalUser -Name $localUser -Password (ConvertTo-SecureString -AsPlainText $newPassword -Force)

    Write-Host ("`nThe password for {0} has been changed.`n" -F $localUser)
}

ChangeLocalUsersPassword $localUser $newPassword
