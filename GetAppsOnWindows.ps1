# get applications on Windows

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

function GetApps()
{
    Write-Host "`nGet applications on Windows.`n"
    CheckOsForWindows

    try 
    {
        Write-Host "The applications on this computer are:"
        Get-ChildItem -Path "C:\Program Files*" -Name "*exe" -Recurse -Force
        
        Write-Host "Successfully got applications on Windows." -ForegroundColor Green
    }
    catch 
    {
        Write-Host "Failed to get applications on Windows." -ForegroundColor Red
    }
}

GetApps
