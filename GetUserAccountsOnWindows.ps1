# get user accounts on Windows 

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

function GetUserAccounts()
{
    Write-Host "`nGet user accounts on Windows.`n" 
    CheckOsForWindows

    try 
    {
        Write-Host "The user accounts on this computer are:"
        Get-LocalUser

        Write-Host "Successfully got user accounts.`n" -ForegroundColor Green
    }
    catch 
    {
        Write-Host "Failed to get user accounts.`n" -ForegroundColor Red
    }
}

GetUserAccounts
