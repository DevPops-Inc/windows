# Windows maintenance 

# run this script as admin: Start-Process PowerShell -Verb RunAs

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
        Write-Host "Sorry but this script only runs on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        
        break
    }
}

function CheckDisk()
{
    Write-Host "Started checking disk at" (Get-Date).DateTime

    Write-Output y | chkdsk /f/r c:

    Write-Host "Finished checking disk at" (Get-Date).DateTime
    Write-Host ""
}

function SystemsFileCheck()
{
    Write-Host "Started systems file check at" (Get-Date).DateTime

    SFC /scannow

    Write-Host "Finished systems file check at" (Get-Date).DateTime
    Write-Host ""
}

function ScanWindowsImage()
{
    Write-Host "Started scanning Windows image at" (Get-Date).DateTime

    Dism /Online /Cleanup-Image /ScanHealth

    Write-Host "Finished scanning Windows image at" (Get-Date).DateTime
    Write-Host ""
}

function DefragDisk()
{
    Write-Host "Started defragging disk at" (Get-Date).DateTime

    defrag c: /u

    Write-Host "Finished defragging disk at" (Get-Date).DateTime
    Write-Host ""
}

function InstallWinUpdates()
{
    Write-Host "Started installing Windows updates at" (Get-Date).DateTime

    Install-Module PSWindowsUpdate -Force
    Get-WindowsUpdate -AcceptAll -Install 

    Write-Host "Finished installing Windows updates at" (Get-Date).DateTime
    Write-Host ""
}

function WindowsMaintenance()
{
    Write-Host "`nWindows maintenance.`n"

    CheckOsForWindows

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started Windows maintenance at:" $startDateTime.DateTime

        CheckDisk
        SystemsFileCheck
        ScanWindowsImage

        $disk = Get-PhysicalDisk

        if ($disk.MediaType -eq "HDD")
        {
            DefragDisk
        }

        InstallWinUpdates
        Write-Host "Successfully performed maintenance on Windows." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished Windows maintenance at:" $finishedDateTime.DateTime
        
        $duration = New-TimeSpan $startDateTime $finishedDateTime
        
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""

        Write-Host "Please save your documents and close applications."
        Read-Host -Prompt "Press any key to restart your computer"
        Restart-Computer
    }
    catch
    {
        Write-Host "Failed to perform maintenance on Windows." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

WindowsMaintenance
