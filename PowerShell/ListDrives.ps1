# list drives

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
    Write-Host "`nList drives.`n"
    CheckOs

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started listing drives at" $startDateTime.DateTime

        Get-PSDrive | Out-String
        Write-Host "Successfully listed drives." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished listing drives at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch 
    {
        Write-Host "Failed to list drives." -Foreground Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

GetListOfDrives
