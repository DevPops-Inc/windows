# get printer list on Windows

function CheckOsForWindows()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win_32_OperatingSystem).Caption -ForegroundColor Green

        Write-Host "Finished checking operating system at:" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "Operating System:" $hostOs
        Write-Host "Sorry but this script only run on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host 
        break
    }
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
