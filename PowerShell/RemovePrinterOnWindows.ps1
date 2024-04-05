# remove printer on Windows

# run this script as admin: Start-Process PowerShell -Verb RunAs
# you can run this script with: .\RemovePrinterOnWindow.ps1 -printerName '< printer >' 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $printerName = "" # you can set the printer name here
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

function GetPrinterName([string]$printerName)
{
    if (($printerName -eq $Null) -or ($printerName -eq ""))
    {
        $printerName = Read-Host -Prompt "Please type printer you wish to remove and press the `"Enter`" key (Example: HP_printer)"

        Write-Host ""
        return $printerName
    }
    else
    {
        return $printerName
    }
}

function CheckParameters([string]$printerName)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-----------------------------------"
    Write-Host ("printerName: {0}" -F $printerName)
    Write-Host "-----------------------------------"

    if (($printerName -eq $Null) -or ($printerName -eq ""))
    {
        Write-Host "printerName is not set." -ForegroundColor Red
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
        Write-Host "One or more parameter checks are incorrect." -ForegroundColor Red

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""

        break
    }
}

function RemovePrinter([string]$printerName)
{
    Write-Host "`nRemove printer on Windows.`n"
    CheckOsForWindows

    Write-Host "The printers on this computer are:"
    Get-Printer | Format-Table -AutoSize

    $printerName = GetPrinterName $printerName
    CheckParameters $printerName

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started removing printer at" $startDateTime.DateTime

        Remove-Printer -Name $printerName
        
        Write-Host "The printers on this computer are:"
        Get-Printer | Format-Table -AutoSize

        Write-Host ("Successfully removed {0}." -F $printerName) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished removing printer at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch 
    {
        Write-Host ("Failed to remove {0}." -F $printerName) -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""

        Write-Host "The printers on this computer are:"
        Get-Printer | Format-Table -AutoSize
    }
}

RemovePrinter $printerName
