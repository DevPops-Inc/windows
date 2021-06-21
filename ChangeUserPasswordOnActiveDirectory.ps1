# change user password on Active Directory

[CmdletBinding()]
param
(
      [string] [Parameter(Mandatory = $False)] $userName = ""
    , [string] [Parameter(Mandatory = $False)] $newPassword = ""
)

function GetUserName([string]$userName)
{
    if (($userName -eq $Null) -or ($userName -eq ""))
    {
        $userName = Read-Host -Prompt "`nWhat is the username you would like to password for? (Example: ADUser)"
        return $userName
    }
    else
    {
        return $userName
    }
}

function GetNewPassword([string]$newPassword)
{
    if (($newPassword -eq $Null) -or ($newPassword -eq ""))
    {
        $newPassword = Read-Host -Prompt "`nWhat is the new password? (Example: Password123)"
        return $newPassword
    }
    else
    {
        return $newPassword
    }
}

function changeUserPasswordOnActiveDirectory()
{
    Write-Host "`nChange user password on Active Directory.`n"

    GetUserName $userName
    GetNewPassword $newPassword

    Set-ADAccountPassword -Identity $userName -NewPassword (ConvertTo-SecureString -AsPlainText $newPassword -Force)

    Write-Host ("`nThe password for {0} has been changed.`n" -F $userName)
}
