# install printer on Windows

# you can run this script with: InstallPrinterOnWindows.ps1 -ipAddress < IP address > -printerName < printer name > -driverName < driver name >

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $ipAddress = ""
    , [string] [Parameter(Mandatory = $False)] $printerName = ""
    , [string] [Parameter(Mandatory = $False)] $driverName = ""
)

function GetIpAddress([string]$ipAddress)
{
    if (($ipAddress -eq $Null) -or ($ipAddress -eq ""))
    {
        $ipAddress = Read-Host -Prompt "`nPlease type the IP address of the printer you wish to add (Example: 10.4.2.8)"

        return $ipAddress
    }
    else 
    {
        return $ipAddress
    }
}

function GetPrinterName([string]$printerName)
{
    if (($printerName -eq $Null) -or ($printerName -eq ""))
    {
        $printerName = Read-Host -Prompt "`nPlease type the name of the printer you wish to install (Example: Office-Printer)"

        return $printerName
    }
    else 
    {
        return $printerName
    }
}

function GetDriverName([string]$driverName)
{
    if (($printerName -eq $Null) -or ($printerName -eq ""))
    {
        $driverName = Read-Host -Prompt "`nPlease type the driver name you wish to install for this printer (Example: CanonMF4320)"

        return $driverName
    }
    else 
    {
        return $driverName
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

function InstallPrinter([string]$ipAddress, [string]$printerName, [string]$driverName)
{
    Write-Host "`nInstall printer on Windows.`n"
    CheckOsForWindows

    try
    {
        Add-PrinterPort -Name $ipAddress -PrinterHostAddress $ipAddress

        Add-Printer -Name $printerName -DriverName $driverName -PortName $ipAddress

        Write-Host ("Successfully installed {0} printer on this computer." -F $printerName) -ForegroundColor Green

        Write-Host "Printers on this computers are:"
        Get-Printer
    }
    catch 
    {
        Write-Host ("Failed to install {0} printer on this computer.`n" -F $printerName) -ForegroundColor Red
    }
}

InstallPrinter $ipAddress $printerName $driverName
