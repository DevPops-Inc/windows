# shutdown computer on Windows 

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

function ShutdownComputer()
{
    Write-Host "`nShutdown computer on Windows.`n"
    #CheckOsForWindows

    Write-Host "Please save documents and close applications."
    Pause 

    try 
    {
        Stop-Computer -ComputerName localhost
        
        Write-Host "Succesfully shutting down computer now." -ForegroundColor Green
    }
    catch 
    {
        Write-Host "Faild to shutdown computer." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

ShutdownComputer
