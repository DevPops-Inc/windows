# get printer list on Windows

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

function GetPrinterList()
{
    Write-Host "`nGet printer list on Windows.`n"
    CheckOsForWindows

    try 
    {
        Write-Host "`nThe printers on this computer are: "
        Get-Printer
        
        Write-Host "Successfully got printer list on this computer.`n" -Foreground Green
    }
    catch 
    {
        Write-Host "`nFailed to get printers on this computer." -ForegroundColor Red
    }
}

GetPrinterList
