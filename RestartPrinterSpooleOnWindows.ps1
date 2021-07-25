# restart printer spooler on Windows 

function CheckOsForWindows()
{
    Write-Host "`nChecking operating system..."
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green
    }
    else 
    {
        Write-Host "Operating System:" $hostOs
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system.`n"
        break
    }
    Write-Host "Finished checking operating system.`n"
}

function RestartPrinterSpooler()
{
    Write-Host "`nRestart printer spooler on Windows.`n"
    CheckOsForWindows

    try 
    {
        Restart-Service -Name Spooler -Force

        Write-Host "Successfully restarted printer spooler." -ForegroundColor Green
    }
    catch 
    {
        Write-Host "Failed to restart printer spooler." -ForegroundColor Red
    }
}

RestartPrinterSpooler
