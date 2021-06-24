# create new AD user and assign permissions

# you can run this script with: .\CreateNewAdUserAndAsignPerms.ps1 -newAdUser < new Active Directory user >  -newPassword < new password > -groupName < user group > 

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $newAdUser = ""
    , [string] [Parameter(Mandatory = $False)] $newPassword = ""
    , [string] [Parameter(Mandatory = $False)] $groupName = ""
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

function GetGroupName([string]$groupName)
{
    if (($groupName -eq $Null) -or ($groupName -eq ""))
    {
        $groupName = Read-Host -Prompt "`nPlease type the group you want to assign the user to (example: developers)"
        return $groupName
    }
    else 
    {
        return $groupName
    }

}

function CreateNewAdUser([string]$newAdUser, [string]$newPassword, [string]$groupName)
{
    Write-Host "`nCreate new Active Directory user and assign permissions.`n"

    $newAdUser = GetNewAdUser $newADUser
    $newPassword = GetNewPassword $newPassword
    $groupName = GetGroupName $groupName

    try 
    {
        # create new AD user
        New-ADUser $newAdUser 

        # set the password
        Set-ADAccountPassword -Identity $newAdUser -NewPassword (ConvertTo-SecureString -AsPlainText $newPassword -Force)

        # assign permissions
        Add-ADGroupMember -Identity $groupName -Members $newADUser

        Write-Host ("`nNew Active Directory user {0} has been created.`n" -F $newAdUser) -ForegroundColor Green
    }
    catch 
    {
        Write-Host ("`nFailed to create new Active Directory user {0}.`n" -F $newAdUser) -ForegroundColor Red
    }
}

# call CreateNewAdUser function 
CreateNewAdUser $newAdUser $newPassword $groupName
