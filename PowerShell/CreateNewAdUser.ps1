# create new active directory user 

# run this script with: .\CreateNewAdUser.ps1 -newAdUser < new user > -newPassword < new password >

[CmdletBinding()]
param(
    [string]       [Parameter(Mandatory = $False)] $newAdUser   = "", # you can set new AD username here
    [securestring] [Parameter(Mandatory = $False)] $newPassword = $Null # you can set the new AD password here
)

function CheckOsForWin()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System: " (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
    }
    else
    {
        Write-Host "Operating System: " $hostOs
        throw "Sorry but this script only works in Windows." 
    }
}

function GetNewAdUser([string]$newAdUser)
{
    if (($newAdUser -eq $Null) -or ($newAdUser -eq ""))
    {
        $newAdUser = Read-Host -Prompt "Please type the username of the new Active Directory user and press `"Enter`" key (Example: software.developer)"
        
        Write-Host ""
        return $newAdUser
    }
    else
    {
        return $newAdUser
    }
}

function GetNewPassword([securestring]$newPassword)
{
    if (($newPassword -eq $Null) -or ($newPassword -eq ""))
    {
        $newPassword = Read-Host -Prompt "Please type the password for the new user and press `"Enter`" key (Example: Password123)" -AsSecureString
        
        Write-Host ""
        return $newPassword
    }
    else
    {
        return $newPassword
    }
}

function CheckParameters([string]$newAdUser, [securestring]$newPassword)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "---------------------------------"
    Write-Host ("newAdUser  : {0}" -F $newAdUser)
    Write-Host ("newPassword: {0}" -F "***")
    Write-Host "---------------------------------"

    if (($newAdUser -eq $Null) -or ($newAdUser -eq ""))
    {
        Write-Host "newAdUser is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($newPassword -eq $Null) -or ($newPassword -eq ""))
    {
        Write-Host "newPassword is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter check(s) passed." -ForegroundColor -Green

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        throw "One or more parameters are incorrect." 
    }
}

function CreateNewAdUser([string]$newAdUser, [securestring]$newPassword)
{
    Write-Host "`nCreate new Active Directory user.`n"
    CheckOsForWin

    $newAdUser   = GetNewAdUser $newAdUser
    $newPassword = GetNewPassword $newPassword
    CheckParameters $newAdUser $newPassword

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started creating new Active Directory user at: " $startDateTime.DateTime.DateTime

        New-ADUser $newAdUser 

        Set-ADAccountPassword -Identity $newAdUser -NewPassword (ConvertTo-SecureString -AsPlainText $newPassword -Force)

        Write-Host ("Successfully created new Active Directory user {0}." -F $newAdUser) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished creating new Active Directory user at: " $finishedDateTime.DateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host "Failed to create new Active Directory user." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

CreateNewAdUser $newAdUser $newPassword
