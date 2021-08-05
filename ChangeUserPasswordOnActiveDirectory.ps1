# change user password on Active Directory

# you can run this script with: .\ChangeUserPasswordOnActiveDirectory.ps1 -userName < username > -newPassword < new password > 

[CmdletBinding()]
param
(
      [string]       [Parameter(Mandatory = $False)] $userName = ""
    , [securestring] [Parameter(Mandatory = $False)] $newPassword = $Null
)

function GetUserName([string]$userName)
{
    if (($userName -eq $Null) -or ($userName -eq ""))
    {
        $userName = Read-Host -Prompt "Please type the username you would like to password for and press `"Enter`" key (Example: ADUser)"
        
        return $userName
    }
    else
    {
        return $userName
    }
}

function GetNewPassword([securestring]$newPassword)
{
    if (($newPassword -eq $Null) -or ($newPassword -eq ""))
    {
        $newPassword = Read-Host -Prompt "Please type the new password and press `"Enter`" key (Example: Password123)" -AsSecureString
        
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
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green
    }
    else 
    {
        Write-Host "Operating System:" $hostOs
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system.`n"
        break
    }
    Write-Host "Finished checking operating system.`n"
}

function ChangeUserPasswordOnActiveDirectory([string]$userName, [securestring]$newPassword)
{
    Write-Host "`nChange user password on Active Directory.`n"
    CheckOsForWindows

    $userName = GetUserName $userName
    $newPassword = GetNewPassword $newPassword

    try
    {
        $startDateTime = (Get-Date)
        
        Write-Host "Started changing user password on Active Directory at: " $startDateTime

        Set-ADAccountPassword -Identity $userName -NewPassword (ConvertTo-SecureString -AsPlainText $newPassword -Force)

        Write-Host ("Successfully change the password for {0}." -F $userName) -ForegroundColor Green

        $finishedDateTime = (Get-Date)

        Write-Host "Finished changing user password on Active Directory at: " $finishedDateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch
    {
        Write-Host ("Failed to change the password for {0}." -F $userName) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

ChangeUserPasswordOnActiveDirectory $userName $newPassword
