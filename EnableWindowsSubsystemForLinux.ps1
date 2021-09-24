# enable Windows Subsystem for Linux (WSL)

function CheckOsForWindows()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green

        Write-Host "Finished checking operating at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "Operating System:" $hostOs

        Write-Host "Sorry but this script only works in Windows" -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
    }
}

function EnableWsl()
{
    Write-Host "`nEnable Windows Subsystem for Linux.`n"
    CheckOsForWindows 

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started enabling Windows Subsystem for Linux at" $startDateTime

        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -Force
        
        Write-Host "`nSuccessfully enabled Windows Subsystem for Linux.`n" -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished enabling Windows Subsystem for Linux at" $finishedDateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host "`nFailed to enable Windows Subsystem for Linux.`n" -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

EnableWsl
