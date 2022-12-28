# remove contact from Exchange

# haven't tested this script yet
# you can run this script with: .\RemoveContactFromExchange.ps1 -contactName '< contact >'

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $contactName = "" # you can set the contact name here
)

function GetContactName([string]$contactName)
{
    if (($contactName -eq $Null) -or ($contactName -eq ""))
    {
        $contactName = Read-Host -Prompt "Please type the contact you wish to remove and press `"Enter`" key (Example: software.vendor)"

        return $contactName
    }
    else
    {
        return $contactName
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
