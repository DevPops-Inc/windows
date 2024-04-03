# list printer ports on Windows

function CheckOsForWindows()
{
    Write-Host "Start checking operating system at" (Get-Date).DateTime
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
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        break
    }
}

function ListPrinterPorts()
{
    Write-Host "`nGet printer ports on Windows.`n"
    CheckOsForWindows

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started getting printer ports at" $startDateTime.DateTime
        
        Get-PrinterPort
        Write-Host "Successfuly got printer ports on this computer." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished getting printer ports at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime
        
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host "Failed to get printer ports on this computer." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

ListPrinterPorts
