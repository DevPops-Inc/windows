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
        $localAdmin = Read-Host -Prompt "Please the admin name (Example: 'Foo.Bar')"

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
        $password = Read-Host -Prompt "Please type the password (Example: 'Password1234')"

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
        $description = Read-Host -Prompt "Please type the description (Example: 'Local Admin')"

        return $description
    }
    else
    {
        return $description
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

function CreateLocalAdmin([string]$localAdmin, [string]$password, [string]$description)
{
    Write-Host "`nCreate local admin on Windows.`n"
    CheckOsForWindows

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

        Write-Host ("Successfully created local admin {0}." -F $localAdmin) -ForegroundColor Green
        
        # check if new user has been added
        Write-Host "The users on this computer are: "
        Get-LocalUser
    }
    catch
    {
        Write-Host ("Faild to create local admin {0}." -F $localAdmin) -ForegroundColor Red

        Write-Host "The users on this computer are:"
        Get-LocalUser
    }
}

CreateLocalAdmin $localAdmin $password $description
