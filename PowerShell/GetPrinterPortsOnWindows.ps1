# get printer ports on Windows

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

function GetPrinterPortsOnWindows()
{
    Write-Host "`nGet printer ports on Windows.`n"
    CheckOsForWindows

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started getting printer ports at" $startDateTime.DateTime

        Write-Host "The printer ports on this computer are: "
        Get-PrinterPort

        Write-Host "Successfuly got printer ports on this computer.`n" -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished getting printer ports at" $finishedDateTime.DateTime
    }
    catch
    {
        Write-Host "Failed to get printer ports on this computer.`n" -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

GetPrinterPortsOnWindows
