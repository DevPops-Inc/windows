# Windows maintenance function

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

function WindowsMaintenance()
{
    Write-Host "`nWindows maintenance.`nYou need to elevate permissions before running this script: Start-Process Powershell -Verb runAs`n"

    #CheckOsForWindows

    $startDateTime = (Get-Date)
    Write-Host "Starting Windows Maintenance at:" $startDateTime

    try 
    {
        Write-Host "`nStarting check disk..."
        Write-Output y | chkdsk /f/r c:
        Write-Host "Finished checking disk."
    
        Write-Host "`nStarting systems file check..."
        SFC /scannow
        Write-Host "Finished systems file check."
    
        Write-Host "`nScanning Windows image..."
        Dism /Online /Cleanup-Image /ScanHealth
        Write-Host "Finished scanning Windows image."
        
        Write-Host "`nStarting to defrag disk..."
        defrag c: /u
        Write-Host "Finished defragging disk."

        Write-Host "`nSuccessfully performed maintenance on Windows." -ForegroundColor Green
    }
    catch
    {
        Write-Host "`nFailed to perform maintenance on Windows." -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
    finally
    {
        $finishedDateTime = (Get-Date)
        Write-Host "`nFinished Windows maintenance at:" $finishedDateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host "`nPlease save your documents and close applications."
        Pause
        shutdown /r /t 0
    }
}

WindowsMaintenance
