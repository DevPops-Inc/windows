# install Windows updates

function CheckOsForWindows()
{
    Write-Host "Started Checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "Operating System is:" $hostOs
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        break
    }
}

function InstallWinUpdates()
{
    Write-Host "`nInstall Windows Updates.`n"
    CheckOsForWindows

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started installing Windows updates at" $startDateTime

        Get-WindowsUpdate -Install -AcceptAll

        $finishedDateTime = (Get-Date)
        Write-Host "Finished installing Windows updates at" $finishedDateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $durations.Seconds)
    }
    catch 
    {
        Write-Host "Failed to install Windows updates" -Foreground Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

InstallWinUpdates
