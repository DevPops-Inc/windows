# defrag disk on Windows

function DefragDisk()
{
    Write-Host "`nDefrag disk on Windows`n"

    try
    {
        # defrag disk
        defrag c: /u

        Write-Host "`nDefrag disk was successful.`n" -ForegroundColor Green
    }
    catch
    {
        Write-Host "`nDefrag disk failed.`n" -ForegroundColor Red
    }
}

DefragDisk
