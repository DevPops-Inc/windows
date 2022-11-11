# get system info on Windows 

function GetSystemInfo()
{
    try 
    {
        Write-Host "`nGet system info on Windows.`n"

        # get system info 
        systeminfo
    }
    catch 
    {
        Write-Host "`nFailed to get system info.`n" -ForegroundColor -Red
    }
}

GetSystemInfo
