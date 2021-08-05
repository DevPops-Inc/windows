# check disk and restart Windows

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

function CheckDiskAndRestartWindows()
{
    Write-Host "`nCheck disk and restart on Windows.`n"
    CheckOsForWindows

    try
    {
        $startDateTime = (Get-Date)
        
        Write-Host "Started checking disk and restarting Windows at: " $startDateTime

        Write-Output y | chkdsk /f/r c:

        Write-Host "Please save your documents and close applications."
        Pause
    
        Write-Host "Successfully checked disk and restarted Windows." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        
        Write-Host "Finished checking disk and restarting Windows at: " $finishedDateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime
        
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Restart-Computer
    }
    catch
    {
        Write-Host "Failed to check disk and restart Windows." -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

CheckDiskAndRestartWindows
