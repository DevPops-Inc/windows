# enable SMB2 on Windows

function EnableSmb2OnWindows()
{
    Write-Host "`nEnable SMB2 on Windows.`n"

    try 
    {
        Get-SmbServerConfiguration | Select-Object EnableSMB2Protocol

        Write-Host "`nSuccessfully enabled SMB2.`n" -ForegroundColor Green
    }
    catch 
    {
        Write-Host "`nFailed to enable SMB2.`n" -ForegroundColor Red
    }
}

EnableSmb2OnWindows
