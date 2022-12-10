# shutdown computer on Windows 

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

function ShutdownComputer()
{
    Write-Host "`nShutdown computer on Windows.`n"
    CheckOsForWindows

    Read-Host -Prompt "Please save documents and close applications. Press any key to continue"

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started shutting down computer at" $startDateTime.DateTime

        Stop-Computer -ComputerName localhost
        
        Write-Host "Succesfully shutting down computer now." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished shutting down computer at" $finishedDateTime.DateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host "Failed to shutdown computer." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

ShutdownComputer
