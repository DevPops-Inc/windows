# get programs on Windows

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
        throw "Sorry but this script only runs on Windows."
    }
}

function GetPrograms()
{
    Write-Host "`nGet programs on Windows.`n"
    CheckOsForWin

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started getting programs at" $startDateTime.DateTime

        Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName | Format-Table -AutoSize

        Get-WmiObject -Class Win32_Product | Select-Object -Property Name | Format-Table -AutoSize

        Write-Host "Successfully got programs." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished getting programs at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime
        
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host "Failed to get programs." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

GetPrograms
