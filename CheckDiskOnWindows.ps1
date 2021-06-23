# check disk on Windows

function CheckDisk()
{
    try
    {
        # prompt user input
        Write-Host "`nCheck disk on Windows.`n"

        # check disk and repair C drive
        Write-Output y | chkdsk /f/r c:
    }
    catch
    {
        Write-Host "`nCheck disk failed.`n" -ForegroundColor Red
    }
}

CheckDisk
