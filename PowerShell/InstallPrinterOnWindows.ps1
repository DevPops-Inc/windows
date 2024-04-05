# install printer on Windows

# you can run this script with: InstallPrinterOnWindows.ps1 -ipAddress < IP address > -printerName < printer name > -driverName < driver name >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $ipAddress = "", # you can set the printe's IP address here 
    [string] [Parameter(Mandatory = $False)] $printerName = "", # you can set the printer name here 
    [string] [Parameter(Mandatory = $False)] $driverName = "" # you can set the printer driver here 
)

function CheckOsForWin()
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

function GetIpAddress([string]$ipAddress)
{
    if (($ipAddress -eq $Null) -or ($ipAddress -eq ""))
    {
        $ipAddress = Read-Host -Prompt "Please type the IP address of the printer you wish to add and press `"Enter`" key (Example: 10.4.2.8)"

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
        $printerName = Read-Host -Prompt "Please type the name of the printer you wish to install and press `"Enter`" key (Example: Office-Printer)"

        Write-Host ""
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
        $driverName = Read-Host -Prompt "Please type the driver name you wish to install for this printer and press `"Enter`" key (Example: CanonMF4320)"

        Write-Host ""
        return $driverName
    }
    else 
    {
        return $driverName
    }
}

function CheckParameters([string]$ipAddress, [string]$printerName, [string]$driverName)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-----------------------------------"
    Write-Host ("ipAddress  : {0}" -F $ipAddress)
    Write-Host ("printerName: {0}" -F $printerName)
    Write-Host ("driverName : {0}" -F $driverName)
    Write-Host "-----------------------------------"

    if (($ipAddress -eq $Null) -or ($ipAddress -eq ""))
    {
        Write-Host "ipAddress is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($printerName -eq $Null) -or ($printerName -eq ""))
    {
        Write-Host "printerName is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($driverName -eq $Null) -or ($driverName -eq ""))
    {
        Write-Host "driverName is not set." -ForegroundColor Red
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
        Write-Host "One or more parameter checks are incorrect, exiting script." -ForegroundColor Red
        
        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
        break 
    }
}

function InstallPrinter([string]$ipAddress, [string]$printerName, [string]$driverName)
{
    Write-Host "`nInstall printer on Windows.`n"
    CheckOsForWindows

    $ipAddress = GetIpAddress $ipAddress
    $printerName = GetPrinterName $printerName
    $driverName = GetDriverName $driverName
    CheckParameters $ipAddress $printerName $driverName

    try
    {
        $startDateTime = (Get-Date)
        Write-Host ("Started installing {0} printer at {1}" -F $printerName, $startDateTime)

        Add-PrinterPort -Name $ipAddress -PrinterHostAddress $ipAddress
        Add-Printer -Name $printerName -DriverName $driverName -PortName $ipAddress

        Write-Host ("Successfully installed {0} printer on this computer." -F $printerName) -ForegroundColor Green

        Write-Host "Printers on this computers are:"
        Get-Printer

        $finishedDateTime = (Get-Date)
        Write-Host ("Finished installing {0} printer at {1}" -F $printerName, $finishedDateTime)

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch 
    {
        Write-Host ("Failed to install {0} printer on this computer." -F $printerName) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

InstallPrinter $ipAddress $printerName $driverName
