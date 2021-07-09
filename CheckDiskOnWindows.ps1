# check disk on Windows

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

function CheckDisk()
{
    Write-Host "`nCheck disk on Windows.`n"
    CheckOsForWindows

    try
    {
        # check disk and repair C drive
        Write-Output y | chkdsk /f/r c:
    }
    catch
    {
        Write-Host "Check disk failed." -ForegroundColor Red
    }
}

CheckDisk
