# log out of profile in Windows 

function CheckOsForWin()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green
        
        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "Operating System:" $hostOs
        throw "Sorry but this script only works on Windows." 
    }
}

function LogOutProfile()
{
    Write-Host "`nLog out of profile in Windows.`n"
    CheckOsForWin 

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started logging out of profile at" $startDateTime.DateTime

        logoff /v
        Write-Host "Successfully logged out of profile." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished logging out of profile at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host "Failed to logout." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

LogOutProfile
