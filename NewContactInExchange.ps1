# create new contact in Exchange 

# you can run this script with: .\NewContactInExchange.ps1 -contactName < contact name > -externalEmail < contact email > -orgUnit < organizational unit >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $contactName = "", 
    [string] [Parameter(Mandatory = $False)] $externalEmail = "", 
    [string] [Parameter(Mandatory = $False)] $orgUnit = ""
)

function CheckOsForWindows()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "Operating System:" $hostOs
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        break
    }
}

function GetContactName([string]$contactName)
{
    if ([System.String]::IsNullOrEmpty($contactName) -eq $False)
    {
        $contactName = Read-Host -Prompt "Please type name of the new contact and press `"Enter`" key (Example: Joe Smith)"

        Write-Host ""
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
        $externalEmail = Read-Host -Prompt "Please type contact's email and press `"Enter`" key (Example: j.smith@contact.com)"

        Write-Host ""
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
        $orgUnit = Read-Host -Prompt "Please type organizational unit of contact and press `"Enter`" key (Example: vendors)"

        Write-Host ""
        return $orgUnit
    }
    else 
    {
        return $orgUnit
    }
}

function CheckParameters([string]$contactName, 
                         [string]$externalEmail, 
                         [string]$orgUnit)
{
    Write-Host "Started checking parameters at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameters:"
    Write-Host "---------------------------------------"
    Write-Host ("contactName  : {0}" -F $contactName)
    Write-Host ("externalEmail: {0}" -F $externalEmail)
    Write-Host ("orgUnit:     : {0}" -F $orgUnit)
    Write-Host "---------------------------------------"

    if (($contactName -eq $Null) -or ($contactName -eq ""))
    {
        Write-Host "contactName is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($externalEmail -eq $Null) -or ($externalEmail -eq ""))
    {
        Write-Host "externalEmail is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($orgUnit -eq $Null) -or ($orgUnit -eq ""))
    {
        Write-Host "orgUnit is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter checks passed." -ForegroundColor Green
    }
    else
    {
        Write-Host "One or more parameters are incorrect, exiting script." -ForegroundColor Red

        exit -1
    }

    Write-Host "Finished checking parameters at" (Get-Date).DateTime
    Write-Host ""
}

function NewContactInExchange([string]$contactName, 
                              [string]$externalEmail, 
                              [string]$orgUnit)
{
    Write-Host "`nCreate New Contact in Exchange.`n"
    CheckOsForWindows
    
    $contactName = GetContactName $contactName
    $externalEmail = GetExternalEmail $externalEmail
    $orgUnit = GetOrgUnit $orgUnit
    CheckParameters $contactName $externalEmail $orgUnit
    
    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started creating new contact at" $startDateTime

        New-MailContact -Name $contactName -ExternalEmailAddress $externalEmail -OrganizationalUnit $orgUnit

        Write-Host ("Successfully created contact {0}, {1} in group: {2}." -F $contactName, $externalEmail, $orgUnit) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished creating new contact at" $finishedDateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host ("Failed to create contact {0}, {1} in group: {2}." -F $contactName, $externalEmail, $orgUnit) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

NewContactInExchange $contactName, $externalEmail, $orgUnit
