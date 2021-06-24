# check disk and restart Windows

function CheckDiskAndRestartWindows()
{
    Write-Host "`nCheck disk and restart on Windows.`n"

    try
    {
        Write-Output y | chkdsk /f/r c:

        Write-Host "`nPlease save your documents and close applications.`n"
        Pause
    
        Restart-Computer
    }
    catch
    {
        Write-Host "`nCheck disk failed.`n" -ForegroundColor Red
    }
}

CheckDiskAndRestartWindows
