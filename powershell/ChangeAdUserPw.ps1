# change user password on Active Directory

# you can run this script with: .\ChangeAdUserPw.ps1 -userName < username > -newPassword < new password > 

[CmdletBinding()]
param
(
    [string]       [Parameter(Mandatory = $False)] $userName    = "", # you can set the username here
    [securestring] [Parameter(Mandatory = $False)] $newPassword = $Null # you can set the new password here
)

$ErrorActionPreference = "Stop"

function CheckOsForWin()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "WinNT32")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "Operating System:" $hostOs
        throw "Sorry but this script only runs on Windows." 
    }
}

function GetUserName([string]$userName)
{
    if (($userName -eq $Null) -or ($userName -eq ""))
    {
        $userName = Read-Host -Prompt "Please type the username you would like to password for and press `"Enter`" key (Example: ADUser)"
        
        Write-Host ""
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
        
        Write-Host ""
        return $newPassword
    }
    else
    {
        return $newPassword
    }
}

function CheckParameters([string]$userName, [securestring]$newPassword)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "--------------------------------"
    Write-Host ("userName   : {0}" -F $userName)
    Write-Host ("newPassword: {0}" -F "***")
    Write-Host "--------------------------------"

    if (($userName -eq $Null) -or ($userName -eq ""))
    {
        Write-Host "userName is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($newPassword -eq $Null) -or ($newPassword -eq ""))
    {
        Write-Host "newPassword is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter check(s) passed." -ForegroundColor Green

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        throw "One or more parameters are incorrect."
    }
}

function ChangeUserPw([string]$userName, [securestring]$newPassword)
{
    Write-Host "`nChange user password on Active Directory.`n"
    CheckOsForWin

    $userName    = GetUserName $userName
    $newPassword = GetNewPassword $newPassword
    CheckParameters $userName $newPassword

    try
    {
        $startDateTime = (Get-Date)
        
        Write-Host "Started changing user password on Active Directory at: " $startDateTime.DateTime.DateTime

        Set-ADAccountPassword -Identity $userName -NewPassword (ConvertTo-SecureString -AsPlainText $newPassword -Force)

        Write-Host ("Successfully change the password for {0}." -F $userName) -ForegroundColor Green

        $finishedDateTime = (Get-Date)

        Write-Host "Finished changing user password on Active Directory at: " $finishedDateTime.DateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host ("Failed to change the password for {0}." -F $userName) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

ChangeUserPw $userName $newPassword
