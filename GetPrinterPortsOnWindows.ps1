# get printer ports on Windows

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

function GetPrinterPortsOnWindows()
{
    Write-Host "`nGet printer ports on Windows.`n"
    CheckOsForWindows

    try
    {
        Write-Host "The printer ports on this computer are: "
        Get-PrinterPort

        Write-Host "Successfuly got printer ports on this computer.`n" -ForegroundColor Green
    }
    catch
    {
        Write-Host "Failed to get printer ports on this computer.`n" -ForegroundColor Red
    }
}

GetPrinterPortsOnWindows
