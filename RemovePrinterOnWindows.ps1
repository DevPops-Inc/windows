# remove printer on Windows

# you can run this script with: .\RemovePrinterOnWindow.ps1 -printerName < printer > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $printerName = ""
)

function GetPrinterName([string]$printerName)
{
    if (($printerName -eq $Null) -or ($printerName -eq ""))
    {
        $printerName = Read-Host -Prompt "Please type printer you wish to remove and press `"Enter`" key (Example: HP_printer)"

        return $printerName
    }
    else
    {
        return $printerName
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

function RemovePrinter([string]$printerName)
{
    Write-Host "`nRemove printer on Windows.`n"
    CheckOsForWindows

    Write-Host "The printers on this computer are:"
    Get-Printer

    $printerName = GetPrinterName $printerName

    try 
    {
        Remove-Printer -Name $printerName
        
        Write-Host ("Successfully removed {0}." -F $printerName) -ForegroundColor Green

        Write-Host "The printers on this computer are:"
        Get-Printer
    }
    catch 
    {
        Write-Host ("Failed to remove {0}." -F $printerName) -ForegroundColor Red

        Write-Host "The printers on this computer are:"
        Get-Printer
    }
}

RemovePrinter $printerName
