# remove contact from Exchange

# haven't tested this script yet
# you can run this script with: .\RemoveContactFromExchange.ps1 -contactName '< contact >'

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $contactName = "" # you can set the contact name here
)

function CheckOsForWindows()
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
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""

        break
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

function CheckParamemeters([string]$contactName)
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
        Write-Host "One or more parameters are incorrect." -ForegroundColor Red

        Write-Host "Finished checking parameters at" (Get-Date).DateTime
        Write-Host ""

        break
    }
}

function RemoveContact([string]$contactName)
{
    Write-Host "`nRemove contact from Exchange.`n"
    CheckOsForWindows

    $contactName = GetContactName $contactName

    try 
    {
        Remove-MailContact -Identity $contactName -force
        
        Write-Host ("Successfully removed {0} from Exchange." -F $contactName) -ForegroundColor Green
    }
    catch 
    {
        Write-Host ("Failed to remove {0} from Exchange." -F $contactName) -ForegroundColor Red
    }
}

RemoveContact $contactName
