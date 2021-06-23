# create local admin on Windows

# you can run this script with: .\CreateLocalAdminOnWindows.ps1 -localAdmin < new admin > -password < new password > -description < admin description >
[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $localAdmin = ""
    , [string] [Parameter(Mandatory = $False)] $password = ""
    , [string] [Parameter(Mandatory = $False)] $description = ""
)

function GetLocalAdmin([string]$localAdmin)
{
    if (($localAdmin -eq $Null) -or ($localAdmin -eq ""))
    {
        $localAdmin = Read-Host -Prompt "`nPlease the admin name (Example: 'Foo.Bar')"
        return $localAdmin
    }
    else
    {
        return $localAdmin
    }
}

function GetPassword([string]$password)
{
    if (($password -eq $Null) -or ($password -eq ""))
    {
        $password = Read-Host -Prompt "`nPlease type the password (Example: 'Password1234')"
        return $password
    }
    else
    {
        return $password
    }
}

function GetDescription()
{
    if (($description -eq $Null) -or ($description -eq ""))
    {
        $description = Read-Host -Prompt "`nPlease type the description (Example: 'Local Admin')"
        return $description
    }
    else
    {
        return $description
    }
}

function CreateLocalAdmin([string]$localAdmin, [string]$password, [string]$description)
{
    Write-Host "`nCreate local admin on Windows.`n"

    $localAdmin = GetLocalAdmin $localAdmin
    $password = GetPassword $password
    $description = GetDescription $description

    try
    {
        # create new user and set password
        New-LocalUser "$localAdmin" -Password $password -FullName "$localAdmin" -Description "$description"

        # add new user as local administrator
        Add-LocalGroupMember -Group "Administrators" -Member "$localAdmin"

        # set password for new user to never expire
        Set-LocalUser -Name "$localAdmin" -PasswordNeverExpires 1

        # check if new user has been added
        Write-Host "`nThe users on this computer are: `n"
        Get-LocalUser

        Write-Host ("`nLocal admin {0} has been created.`n" -F $localAdmin) -ForegroundColor Green
    }
    catch
    {
        Write-Host "`nThe users on this computer are: `n"
        Get-LocalUser

        Write-Host ("`nLocal admin {0} failed to be created.`n" -F $localAdmin) -ForegroundColor Red
    }
}
