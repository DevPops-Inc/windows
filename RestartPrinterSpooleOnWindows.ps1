# restart printer spooler on Windows 

function CheckOsForWindows()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host "'"
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

function RestartPrinterSpooler()
{
    Write-Host "`nRestart printer spooler on Windows.`n"
    CheckOsForWindows

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started restarting printer at" $startDateTime

        Restart-Service -Name Spooler -Force

        Write-Host "Successfully restarted printer spooler." -ForegroundColor Green

        $finishedDateTime = (Get-Date).DateTime
        Write-Host "Finished restarting printer at" $finishedDateTime
    }
    catch 
    {
        Write-Host "Failed to restart printer spooler." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

RestartPrinterSpooler
