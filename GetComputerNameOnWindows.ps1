# get computer name on Windows 

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

function GetComputerName()
{
    Write-Host "`nGet computer name on Windows.`n"

    CheckOsForWindows
    
    try 
    {
        $hostName = $Env:COMPUTERNAME
        
        Write-Host "Successfully got your computer name." -ForegroundColor Green
        Write-Host "Your computer name is:" $hostName
    }
    catch 
    {
        Write-Host "Failed getting your computer name.`n" -ForegroundColor Red
    }
}

GetComputerName
