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
        $email = Read-Host -Prompt "`nPlease type the new email you wish to create (Example: dev@vicphan.dev)"
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
        $password = Read-Host -Prompt "`nPlease type the password for the email account (Example: Password123)"
        return $password
    }
    else 
    {
        return $password    
    }
}

function GetFirstName([string]$firstName)
{
    if (($firstName -eq $Null) -or ($firstName -eq ""))
    {
        $firstName = Read-Host -Prompt "`nPlease type the first name for the account (Example: Software)"
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
        $lastName = Read-Host -Prompt "`nPlease type the last name for the account (Example: Developer)"
        return $lastName
    }
    else 
    {
        return $lastName
    }
}

function CreateRemoteMailboxInExchange([string]$email, [string]$password, [string]$firstName, [string]$lastName)
{
    Write-Host "`nCreate remote mailbox in Exchange.`n"

    $email = GetEmail $email
    $password = GetPassword $password
    $firstName = GetFirstName $firstName
    $lastName = GetLastName $lastName

    try 
    {
        # create remote mailbox 
        New-Mailbox -UserPrincipalName $email  -Name $firstName$lastName -OrganizationalUnit Users -Password $password -FirstName $firstName -LastName $lastName -DisplayName "$firstName $lastName" -ResetPasswordOnNextLogon $false    

        Write-Host ("`nRemote mailbox {0} successfully created for {1} {2}.`n" -F $email, $firstName, $lastName) -ForegroundColor Green
    }
    catch 
    {
        Write-Host ("`nFailed to create remote mailbox {0}`n" -F $email) -ForegroundColor Red
    }
}

CreateRemoteMailboxInExchange $email $password $firstName $lastName
