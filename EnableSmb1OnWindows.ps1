# enable SMB1 on Windows 

function EnableSmb1()
{
    Write-Host "`nEnable SMB1 on Windows.`n"

    try
    {
        Enable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -All

        Write-Host "`nSuccessfully enabled SMB1.`n" -ForegroundColor Green
    }
    catch 
    {
        Write-Host "`nFailed to enable SMB1.`n" -ForegroundColor Red
    }
}

EnableSmb1
