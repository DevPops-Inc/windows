function CheckOsForWindows()
{
    Write-Host "Checking operating system...`n"

    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "You are running this script on Windows.`n" -ForegroundColor Green
    }
    else 
    {
        Write-Host "Your operating system is:" $hostOs
        
        Write-Host "Sorry but this script only works on Windows.`n" -ForegroundColor Red

        break
    }
    Write-Host "Finished checking operating system.`n"
}

CheckOsForWindows
