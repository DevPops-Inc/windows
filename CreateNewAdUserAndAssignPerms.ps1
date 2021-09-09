# create new AD user and assign permissions

# you can run this script with: .\CreateNewAdUserAndAsignPerms.ps1 -newAdUser < new Active Directory user >  -newPassword < new password > -groupName < user group > 

[CmdletBinding()]
param(
      [string]       [Parameter(Mandatory = $False)] $newAdUser = ""
    , [securestring] [Parameter(Mandatory = $False)] $newPassword = $Null
    , [string]       [Parameter(Mandatory = $False)] $groupName = ""
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
        
        break
    }
    Write-Host "Finished checking operating system."
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

function GetGroupName([string]$groupName)
{
    if (($groupName -eq $Null) -or ($groupName -eq ""))
    {
        $groupName = Read-Host -Prompt "`nPlease type the group you want to assign the user to and press `"Enter`" key (example: developers)"
        
        return $groupName
    }
    else 
    {
        return $groupName
    }

}

function CheckParameters([string]$newAdUser, [securestring]$newPassword, [string]$groupName)
{
    Write-Host "`nStarted checking parameters..."
    $valid = $True

    Write-Host "`nParameters:"
    Write-Host "----------------------------------------"
    Write-Host ("newAdUser  : {0}" -F $newAdUser)
    Write-Host ("newPassword: {0}" -F "***")
    Write-Host ("groupName  : {0}" -F $groupName)
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

    if (($groupName -eq $Null) -or ($groupName -eq ""))
    {
        Write-Host "groupName is not set." -ForegroundColor Red
        $valid = $False
    }

    Write-Host "Finished checking parameters."

    if ($valid -eq $True)
    {
        Write-Host "All parameters checks passed.`n" -ForegroundColor Green
    }
    else
    {
        Write-Host "One or more parameters are incorrect, exiting script." -ForegroundColor Red 
        
        exit -1
    }
}

function CreateNewAdUser([string]$newAdUser, [securestring]$newPassword, [string]$groupName)
{
    Write-Host "`nCreate new Active Directory user and assign permissions.`n"
    CheckOsForWindows

    $newAdUser = GetNewAdUser $newADUser
    $newPassword = GetNewPassword $newPassword
    $groupName = GetGroupName $groupName
    CheckParameters $newAdUser $newPassword $groupName

    try 
    {
        $startDateTime = (Get-Date)
        
        Write-Host "Started creating new Active Directory user and assigning permissions at: " $startDateTime

        New-ADUser $newAdUser 

        Set-ADAccountPassword -Identity $newAdUser -NewPassword (ConvertTo-SecureString -AsPlainText $newPassword -Force)

        Add-ADGroupMember -Identity $groupName -Members $newADUser

        Write-Host ("Successfully created new Active Directory user {0}." -F $newAdUser) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        
        Write-Host "Finished creating new Active Directory user and assigning permissions at: " $finishedDateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host ("Failed to create new Active Directory user {0}." -F $newAdUser) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

CreateNewAdUser $newAdUser $newPassword $groupName
