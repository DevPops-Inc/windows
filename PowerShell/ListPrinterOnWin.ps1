# get list printers on Windows

function CheckOsForWindows()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green

        Write-Host "Finished checking operating system at:" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "Operating System:" $hostOs
        throw "Sorry but this script only run on Windows." 
    }
}

function ListPrinters()
{
    Write-Host "`nList printers on Windows.`n"
    CheckOsForWindows

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started listing printers at" $startDateTime.DateTime

        Get-Printer | Out-String
        Write-Host "Successfully listed printers on this computer." -Foreground Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished listing printers at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch 
    {
        Write-Host "Failed to list printers on this computer." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

ListPrinters
