# install printer on Windows

# prompt user input 
Write-Host "`nInstall printer on Windows."
Pause

# declare variables
$ipAddress = Read-Host -Prompt '`nWhat is the IP address of the printer you wish to add? (Example: 10.4.2.8)`n'
$printerName = Read-Host -Prompt '`nWhat is the name of the printer you wish to install? (Example: Office-Printer)`n'
$driverName = Read-Host -Prompt '`nWhat is the driver name you wish to install for this printer? (Example: CanonMF4320)`n'

# define InstallPrinter function
function InstallPrinter()
{
    # add printer port and host address
    Add-PrinterPort -Name $ipAddress -PrinterHostAddress $ipAddress

    # install printer
    Add-Printer -Name $printerName -DriverName $driverName -PortName $ipAddress

    # get printer list
    Get-Printer
}

# call install printer function 
InstallPrinter
