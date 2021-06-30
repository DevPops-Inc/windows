# get running processes

function GetRunningProcesses()
{
    Write-Host "`nGet running processes.`n"

    try 
    {
        Write-Host "The Processes running on this computer are: "
        Get-Process

        Write-Host "`nSuccessfully got processes on this computer.`n" -ForegroundColor Green
    }
    catch
    {
        Write-Host "`nFailed to get processes on this computer.`n" -ForegroundColor Red
    }
}

GetRunningProcesses
