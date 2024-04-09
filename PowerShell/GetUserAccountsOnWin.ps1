# get user accounts on Windows 

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

function GetUserAccounts()
{
    Write-Host "`nGet user accounts on Windows.`n" 
    CheckOsForWin

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started getting user accounts at" $startDateTime.DateTime

        Write-Host "The user accounts on this computer are:"
        Get-LocalUser | Out-String
        Write-Host "Successfully got user accounts." -ForegroundColor Green
        
        $finishedDateTime = (Get-Date)
        Write-Host "Finished getting user accounts at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime
        
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
        
        Write-Host ""
    }
    catch 
    {
        Write-Host "Failed to get user accounts." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

GetUserAccounts
