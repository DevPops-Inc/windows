# check disk and restart Windows

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

function CheckDiskAndRestartWindows()
{
    Write-Host "`nCheck disk and restart on Windows.`n"
    CheckOsForWindows

    try
    {
        Write-Output y | chkdsk /f/r c:

        Write-Host "Please save your documents and close applications."
        Pause
    
        Restart-Computer
    }
    catch
    {
        Write-Host "Check disk failed." -ForegroundColor Red
    }
}

CheckDiskAndRestartWindows
