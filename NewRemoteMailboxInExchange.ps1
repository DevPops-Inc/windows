# create remote mailbox in Exchange

# you can run this script with: .\CreateRemoteMailboxInExchange.ps1 -email < email > -password < password > -firstName < first name > -lastName < last name >

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $email = ""
    , [string] [Parameter(Mandatory = $False)] $password = ""
    , [string] [Parameter(Mandatory = $False)] $firstName = ""
    , [string] [Parameter(Mandatory = $False)] $lastName = ""
)

function GetEmail([string]$email)
{
    if (($email -eq $Null) -or ($email -eq ""))
    {
        $email = Read-Host -Prompt "Please type the new email you wish to create (Example: dev@vicphan.dev)"

        return $email
    }
    else
    {
        return $email
    }
}

function GetPassword([string]$password)
{
    if (($password -eq $Null) -or ($password -eq ""))
    {
        $password = Read-Host -Prompt "Please type the password for the new email account (Example: Password123)"

        return $password
    }
    else
    {
        return $password
    }
}

function GettFirstName([string]$firstName)
{
    if (($firstName -eq $Null) -or ($firstName -eq ""))
    {
        $firstName = Read-Host -Prompt "Please type the first name for the new account (Example: Software)"

        return $firstName
    }
    else 
    {
        return $firstName
    }
}

function GetLastName([string]$lastName)
{
    if (($lastName -eq $Null) -or ($lastName -eq ""))
    {
        $lastName = Read-Host -Prompt "Please type the last name for the new account (Example: Developer)"

        return $lastName
    }
    else
    {
        return $lastName
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

function NewRemoteMailboxInExchange([string]$email, [string]$password, [string]$firstName, [string]$lastName)
{
    Write-Host "`nCreate remote mailbox in Exchange.`n"
    CheckOsForWindows

    $email = GetEmail $email
    $password = GetPassword $password
    $firstName = GettFirstName $firstName
    $lastName = GetLastName $lastName

    try 
    {
        New-Mailbox -UserPrincipalName $email  -Name $firstName$lastName -OrganizationalUnit Users -Password $password -FirstName $firstName -LastName $lastName -DisplayName "$firstName $lastName" -ResetPasswordOnNextLogon $false

        Write-Host ("Successfully created new mailbox: {0}" -F $email) -ForegroundColor Green
    }
    catch 
    {
        Write-Host ("Failed to create new mailbox: {0}" -F $email) -ForegroundColor Red
    }
}

NewRemoteMailboxInExchange $email $password $firstName $lastName
