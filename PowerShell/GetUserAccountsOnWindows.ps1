# get user accounts on Windows 

function CheckOsForWindows()
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
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system."
        Write-Host ""
        break
    }
}

function GetUserAccounts()
{
    Write-Host "`nGet user accounts on Windows.`n" 
    CheckOsForWindows

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started getting user accounts at" $startDateTime

        Write-Host "The user accounts on this computer are:"
        Get-LocalUser

        Write-Host "Successfully got user accounts." -ForegroundColor Green
        
        $finishedDateTime = (Get-Date)
        Write-Host "Finished getting user accounts at" $finishedDateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime
        
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host "Failed to get user accounts." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

GetUserAccounts
