# create new active directory user 

# run this script with: .\CreateNewAdUser.ps1 -newAdUser < new user > -newPassword < new password >

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $newAdUser = ""
    , [string] [Parameter(Mandatory = $False)] $newPassword = ""
)

function GetNewAdUser([string]$newAdUser)
{
    if (($newAdUser -eq $Null) -or ($newAdUser -eq ""))
    {
        $newAdUser = Read-Host -Prompt "`nPlease type the username of the new Active Directory user (Example: software.developer)"
        return $newAdUser
    }
    else
    {
        return $newAdUser
    }
}

function GetNewPassword([string]$newPassword)
{
    if (($newPassword -eq $Null) -or ($newPassword -eq ""))
    {
        $newPassword = Read-Host -Prompt "`nPlease type the password for the new user (Example: Password123)"
        return $newPassword
    }
    else
    {
        return $newPassword
    }
}

function CreateNewAdUser([string]$newAdUser, [string]$newPassword)
{
    Write-Host "`nCreate new Active Directory user.`n"

    try
    {
        # create new AD user
        New-ADUser $newAdUser 

        # set the password
        Set-ADAccountPassword -Identity $newAdUser -NewPassword (ConvertTo-SecureString -AsPlainText $newPassword -Force)

        Write-Host ("`nNew Active Directory user {0} has been created.`n" -F $newAdUser) -ForegroundColor Green
    }
    catch
    {
        Write-Host "`nFailed to create new Active Directory user.`n" -ForegroundColor Red
    }
}

CreateNewAdUser $newAdUser $newPassword
