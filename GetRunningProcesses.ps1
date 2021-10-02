# get running processes

function CheckOs()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green
    }
    else 
    {
        Write-Host "Operating System:" $hostOs -ForegroundColor Green
    }

    Write-Host "Finished checking operating system at" (Get-Date).DateTime
    Write-Host ""
}

function GetRunningProcesses()
{
    Write-Host "`nGet running processes.`n"
    CheckOs

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started getting running processes at" $startDateTime

        Write-Host "The Processes running on this computer are: "
        Get-Process

        Write-Host "`nSuccessfully got processes on this computer.`n" -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished getting running processes at" $finishedDateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch
    {
        Write-Host "`nFailed to get processes on this computer.`n" -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

GetRunningProcesses
