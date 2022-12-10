# get list of drives

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

function GetListOfDrives()
{
    Write-Host "`nGet list of drives.`n"
    CheckOs

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started getting list of drives at" $startDateTime.DateTime

        Get-PSDrive

        Write-Host "`nSuccessfully got list of drives on this computer" -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished getting list of drives at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host "`nFailed to get list of drives on this computer.`n" -Foreground Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

GetListOfDrives
