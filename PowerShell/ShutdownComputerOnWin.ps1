# shutdown computer on Windows 

$ErrorActionPreference = "Stop"

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
        throw "Sorry but this script only works on Windows." 
    }
}

function ShutdownComputer()
{
    Write-Host "`nShutdown computer on Windows.`n"
    CheckOsForWin

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started shutting down computer at" $startDateTime.DateTime

        Write-Host "Please save your documents and close your applications." 
        Read-Host -Prompt "Press any key to shutdown your computer" 
        Write-Host "Succesfully shut down computer." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished shutting down computer at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
        Stop-Computer -ComputerName localhost
    }
    catch 
    {
        Write-Host "Failed to shutdown computer." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

ShutdownComputer
