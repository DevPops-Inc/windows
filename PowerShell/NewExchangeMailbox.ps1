# create remote mailbox in Exchange

# you can run this script with: .\NewExchangeMailbox.ps1 -email < email > -password < password > -firstName < first name > -lastName < last name >

[CmdletBinding()]
param(
      [string]       [Parameter(Mandatory = $False)] $email     = "" # you can set the email you wish to create here
    , [securestring] [Parameter(Mandatory = $False)] $password  = $Null # you can set the password for the email here 
    , [string]       [Parameter(Mandatory = $False)] $firstName = "" # you can set the user's first name here 
    , [string]       [Parameter(Mandatory = $False)] $lastName  = "" # you can set the user's last name here 
)

function CheckOsForWin()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        write-Host ""
    }
    else 
    {
        Write-Host "Operating System:" $hostOs
        throw "Sorry but this script only works on Windows." 
    }
}
function GetEmail([string]$email)
{
    if (($email -eq $Null) -or ($email -eq ""))
    {
        $email = Read-Host -Prompt "Please type the new email you wish to create and press `"Enter`" key (Example: dev@vicphan.dev)"

        Write-Host ""
        return $email
    }
    else
    {
        return $email
    }
}

function GetPassword([securestring]$password)
{
    if (($password -eq $Null) -or ($password -eq ""))
    {
        $password = Read-Host -Prompt "Please type the password for the new email account and press `"Enter`" (Example: Password123)" -AsSecureString

        Write-Host ""
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
        $firstName = Read-Host -Prompt "Please type the first name for the new account and press `"Enter`" key (Example: Software)"

        Write-Host ""
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
        $lastName = Read-Host -Prompt "Please type the last name for the new account and press `"Enter`" key (Example: Developer)"

        Write-Host ""
        return $lastName
    }
    else
    {
        return $lastName
    }
}

function CheckParameters([string]      $email, 
                         [securestring]$password, 
                         [string]      $firstName, 
                         [string]      $lastName)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-------------------------------"
    Write-Host ("email    : {0}" -F $email)
    Write-Host ("password : {0}" -F "***")
    Write-Host ("firstName: {0}" -F $firstName)
    Write-Host ("lastName : {0}" -F $lastName)
    Write-Host "-------------------------------"

    if (($email -eq $Null) -or ($email -eq ""))
    {
        Write-Host "email is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($password -eq $Null) -or ($password -eq ""))
    {
        Write-Host "password is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($firstName -eq $Null) -or ($firstName -eq ""))
    {
        Write-Host "firstName is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($lastName -eq $Null) -or ($lastName -eq ""))
    {
        Write-Host "lastName is not set." -ForegroundColor Red
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
        throw "One or more parameter checks incorrect." 
    }
}

function NewMailbox([string]      $email, 
                                    [securestring]$password, 
                                    [string]      $firstName, 
                                    [string]      $lastName)
{
    Write-Host "`nCreate remote mailbox in Exchange.`n"
    CheckOsForWin

    $email     = GetEmail $email
    $password  = GetPassword $password
    $firstName = GettFirstName $firstName
    $lastName  = GetLastName $lastName
    CheckParameters $email $password $firstName $lastName

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started creating remote mailbox at" $startDateTime.DateTime

        New-Mailbox -UserPrincipalName $email  -Name $firstName$lastName -OrganizationalUnit Users -Password $password -FirstName $firstName -LastName $lastName -DisplayName "$firstName $lastName" -ResetPasswordOnNextLogon $false

        Write-Host ("Successfully created new mailbox: {0}" -F $email) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished creating remote mailbox at" (Get-Date)
        
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host ("Failed to create new mailbox: {0}" -F $email) -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

NewMailbox $email $password $firstName $lastName
