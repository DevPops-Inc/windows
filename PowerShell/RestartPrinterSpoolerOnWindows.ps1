# restart printer spooler on Windows 

# run this script as admin: Start-Process PowerShell -Verb RunAs

function CheckOsForWindows()
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

function RestartPrinterSpooler()
{
    Write-Host "`nRestart printer spooler on Windows.`n"
    CheckOsForWindows

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started restarting printer spooler at" $startDateTime.DateTime

        Restart-Service -Name Spooler -Force

        Write-Host "Successfully restarted printer spooler." -ForegroundColor Green

        $finishedDateTime = (Get-Date).DateTime
        Write-Host "Finished restarting printer spooler at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
        Write-Host ""
    }
    catch 
    {
        Write-Host "Failed to restart printer spooler." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

RestartPrinterSpooler
