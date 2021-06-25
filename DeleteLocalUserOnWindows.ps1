# delete local user on Windows 

# you can run this script with: .\DeleteLocalUserOnWindows.ps1 -localUser < local user >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $localUser = ""
)

function GetLocalUser([string]$localUser)
{
    if (($localUser -eq $Null) -or ($localUser -eq ""))
    {
        $localUser = Read-Host -Prompt "`nPlease type the local user you would like to delete (Example: LocalUser)"
        return $localUser
    }
    else
    {
        return $localUser
    }
}

function DeleteLocalUser([string]$localUser)
{
    Write-Host "`nDelete local user on Windows.`n"

    $localUser = GetLocalUser $localUser

    try
    {
        # delete local user
        Remove-LocalUser -Name "$localUser"

        Write-Host ("`nLocal user {0} has been deleted.`n" -F $localUser) -ForegroundColor Green

        Write-Host "`nThe users on this computer are: `n"
        Get-LocalUser
    }
    catch
    {
        Write-Host ("`nFailed to delete local user {0}." -F $localUser) -ForegroundColor Red

        Write-Host "`nThe users on this computer are: `n"
        Get-LocalUser
    }
}

DeleteLocalUser $localUser
