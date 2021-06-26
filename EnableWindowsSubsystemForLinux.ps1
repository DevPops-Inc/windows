# enable Windows Subsystem for Linux (WSL)

function EnableWsl()
{
    Write-Host "`nEnable Windows Subsystem for Linux.`n"

    try
    {
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -Force
        
        Write-Host "`nSuccessfully enabled Windows Subsystem for Linux.`n" -ForegroundColor Green
    }
    catch 
    {
        Write-Host "`nFailed to enable Windows Subsystem for Linux.`n" -ForegroundColor Red
    }
}

EnableWsl
