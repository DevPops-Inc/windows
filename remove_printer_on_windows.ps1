# remove printer on Windows

# prompt user input
Write-Host "`nRemove printer on Windows"
Pause

# get printer list
Get-Printer

# declare variables
$printerName = Read-Host "`nPlease type printer you wish to remove (Example: HP_printer): "

# define RemovePrinterOnWindows function
function RemovePrinterOnWindows()
{
    # remove printer
    Remove-Printer -Name $printerName

    # get printer list
    Get-Printer
}

# call RemovePrinterOnWindows function
RemovePrinterOnWindows
