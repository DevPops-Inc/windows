# remove Exchange contact

# haven't tested this script yet
# you can run this script with: .\RemoveExchangeContact.ps1 -contactName '< contact >'

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $contactName = "" # you can set the contact name here
)

function CheckOsForWin()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "You are running this script on Windows." -ForegroundColor Green

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "Your operating system is:" $hostOs
        throw "Sorry but this script only works on Windows." 
    }
}

function GetContactName([string]$contactName)
{
    if (($contactName -eq $Null) -or ($contactName -eq ""))
    {
        $contactName = Read-Host -Prompt "Please type the contact you wish to remove and press the `"Enter`" key (Example: software.vendor)"

        return $contactName
    }
    else
    {
        return $contactName
    }
}

function CheckParameters([string]$contactName)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "----------------------------------"
    Write-Host ("contactName: {0}" -F $contactName)
    Write-Host "----------------------------------"

    if (($contactName -eq $Null) -or ($contactName -eq ""))
    {
        Write-Host "contactName is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter check(s) passed." -ForegroundColor Green

        Write-Host "Finished checking parameters at" (Get-Date).DateTime
        Write-Host ""
    }
    else
    {
        throw "One or more parameters are incorrect." 
    }
}

function RemoveContact([string]$contactName)
{
    Write-Host "`nRemove contact from Exchange.`n"
    CheckOsForWin

    $contactName = GetContactName $contactName
    CheckParameters $contactName

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started removing contact at" $startDateTime.DateTime

        Remove-MailContact -Identity $contactName -force
        
        Write-Host ("Successfully removed {0} from Exchange." -F $contactName) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished removing contact at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch 
    {
        Write-Host ("Failed to remove {0} from Exchange." -F $contactName) -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

RemoveContact $contactName
