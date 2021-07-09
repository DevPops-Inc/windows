# change user password on Active Directory

# you can run this script with: .\ChangeUserPasswordOnActiveDirectory.ps1 -userName < username > -newPassword < new password > 

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
        $userName = Read-Host -Prompt "Please type the username you would like to password for (Example: ADUser)"
        
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
        $newPassword = Read-Host -Prompt "Please type the new password (Example: Password123)"
        
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

function ChangeUserPasswordOnActiveDirectory([string]$userName, [string]$newPassword)
{
    Write-Host "`nChange user password on Active Directory.`n"
    CheckOsForWindows

    $userName = GetUserName $userName
    $newPassword = GetNewPassword $newPassword

    try
    {
        Set-ADAccountPassword -Identity $userName -NewPassword (ConvertTo-SecureString -AsPlainText $newPassword -Force)

        Write-Host ("Successfully change the password for {0}." -F $userName) -ForegroundColor Green
    }
    catch
    {
        Write-Host ("Failed to change the password for {0}." -F $userName) -ForegroundColor Red
    }
}

ChangeUserPasswordOnActiveDirectory $userName $newPassword
