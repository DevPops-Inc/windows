# create new active directory user 

# run this script with: .\CreateNewAdUser.ps1 -newAdUser < new user > -newPassword < new password >

[CmdletBinding()]
param(
      [string]       [Parameter(Mandatory = $False)] $newAdUser = ""
    , [securestring] [Parameter(Mandatory = $False)] $newPassword = $Null
)

function CheckOsForWindows()
{
    Write-Host "`nChecking operating system..."
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System: " (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green
    }
    else
    {
        Write-Host "Operating System: " $hostOs
        
        Write-Host "Sorry but this script only works in Windows." -ForegroundColor Red
        
        Write-Host "Finished checking operating system.`n"
        break
    }
}

function GetNewAdUser([string]$newAdUser)
{
    if (($newAdUser -eq $Null) -or ($newAdUser -eq ""))
    {
        $newAdUser = Read-Host -Prompt "Please type the username of the new Active Directory user and press `"Enter`" key (Example: software.developer)"
        
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
        
        return $newPassword
    }
    else
    {
        return $newPassword
    }
}

function CheckParameters([string]$newAdUser, [securestring]$newPassword)
{
    Write-Host "`nStarted checking parameters..."
    $valid = $True

    Write-Host "`nParameters:"
    Write-Host "----------------------------------------"
    Write-Host ("newAdUser  : {0}" -F $newAdUser)
    Write-Host ("newPassword: {0}" -F "***")
    Write-Host "----------------------------------------"

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

    Write-Host "Finished checking parameters."

    if ($valid -eq $True)
    {
        Write-Host "All parameters checks passed." -ForegroundColor -Green
    }
    else 
    {
        Write-Host "One or more parameters are incorrect, exiting script." -ForegroundColor Red
        exit -1
    }
}

function CreateNewAdUser([string]$newAdUser, [securestring]$newPassword)
{
    Write-Host "`nCreate new Active Directory user.`n"
    CheckOsForWindows

    $newAdUser = GetNewAdUser $newAdUser
    $newPassword = GetNewPassword $newPassword
    CheckParameters $newAdUser $newPassword

    try
    {
        $startDateTime = (Get-Date)
        
        Write-Host "Started creating new Active Directory user at: " $startDateTime

        New-ADUser $newAdUser 

        Set-ADAccountPassword -Identity $newAdUser -NewPassword (ConvertTo-SecureString -AsPlainText $newPassword -Force)

        Write-Host ("Successfully created new Active Directory user {0}." -F $newAdUser) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        
        Write-Host "Finished creating new Active Directory user at: " $finishedDateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch
    {
        Write-Host "Failed to create new Active Directory user." -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

CreateNewAdUser $newAdUser $newPassword
