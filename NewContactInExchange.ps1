# create new contact in Exchange 

# you can run this script with: .\NewContactInExchange.ps1 -contactName < contact name > -externalEmail < contact email > -orgUnit < organizational unit >

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $contactName = ""
    , [string] [Parameter(Mandatory = $False)] $externalEmail = ""
    , [string] [Parameter(Mandatory = $False)] $orgUnit = ""
)

function GetContactName([string]$contactName)
{
    if (($contactName -eq $Null) -or ($contactName -eq ""))
    {
        $contactName = Read-Host -Prompt "Please type name of the new contact (Example: Joe Smith)"

        return $contactName
    }
    else
    {
        return $contactName
    }
}

function GetExternalEmail([string]$externalEmail)
{
    if (($externalEmail -eq $Null) -or ($externalEmail -eq ""))
    {
        $externalEmail = Read-Host -Prompt "Please type contact's email (Example: j.smith@contact.com)"

        return $externalEmail
    }
    else 
    {
        return $externalEmail
    }
}

function GetOrgUnit([string]$orgUnit)
{
    if (($orgUnit -eq $Null) -or ($orgUnit -eq ""))
    {
        $orgUnit = Read-Host -Prompt "Please type organizational unit of contact (Example: vendors)"

        return $orgUnit
    }
    else 
    {
        return $orgUnit
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

function NewContactInExchange([string]$contactName, [string]$externalEmail, [string]$orgUnit)
{
    Write-Host "`nCreate new contact in Exchange.`n"
    CheckOsForWindows
    
    $contactName = GetContactName $contactName
    $externalEmail = GetExternalEmail $externalEmail
    $orgUnit = GetOrgUnit $orgUnit
    
    try
    {
        New-MailContact -Name $contactName -ExternalEmailAddress $externalEmail -OrganizationalUnit $orgUnit

        Write-Host ("Successfully created contact {0}, {1} in group: {2}." -F $contactName, $externalEmail, $orgUnit) -ForegroundColor Green
    }
    catch 
    {
        Write-Host ("Failed to create contact {0}, {1} in group: {2}." -F $contactName, $externalEmail, $orgUnit) -ForegroundColor Red
    }
}

NewContactInExchange $contactName, $externalEmail, $orgUnit
