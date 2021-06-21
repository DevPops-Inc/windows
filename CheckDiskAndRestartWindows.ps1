# check disk and restart Windows

function CheckDiskAndRestartWindows()
{
    Write-Host "`nCheck disk and restart on Windows.`n"

    Write-Output y | chkdsk /f/r c:

    Write-Host "`nPlease save your documents and close applications.`n"
    Pause

    Restart-Computer
}

CheckDiskAndRestartWindows
