# install Windows updates

# run this script as admin: Start-Process PowerShell -Verb RunAs

function CheckOsForWin()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOS -eq "Win32NT")
    {
        Write-Host "Operating System: " (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "Operating System: " $hostOs
        Write-Host "Sorry but this script only runs on Windows." -ForegroundColor Red
        
        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        break
    }
}

function InstallWinUpdates()
{
    Write-Host "`nInstall Windows Updates`n"
    CheckOsForWindows

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started installing Windows updates at" $startDateTime.DateTime
        
        Install-Module PSWindowsUpdate -Force
        Get-WindowsUpdate -AcceptAll -Install 
        Write-Host "Successfully installed Windows updates." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished installing Windows updates at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""

        Write-Host "Please save your documents and close applications."
        Read-Host -Prompt "Press any key to restart your computer"
        Restart-Computer
    }
    catch
    {
        Write-Host "Failed to install Windows updates." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

InstallWinUpdates
