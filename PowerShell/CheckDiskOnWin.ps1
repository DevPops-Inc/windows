# check disk on Windows

function CheckOsForWin()
{
    Write-Host "Started hecking operating system at" (Get-Date).DateTime
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
        throw "Sorry but this script only runs on Windows." 
    }
}

function CheckDisk()
{
    Write-Host "`nCheck disk on Windows.`n"
    CheckOsForWin

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started checking disk at: " $startDateTime.DateTime.DateTime

        Write-Output y | chkdsk /f/r c:
        Write-Host "Successfully checked disk." -ForegroundColor Green
        
        $finishedDateTime = (Get-Date)
        Write-Host "Finished checking disk at: " $finishedDateTime.DateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime
        
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host "Failed to check disk." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

CheckDisk
