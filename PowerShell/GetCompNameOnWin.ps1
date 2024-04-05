# get computer name on Windows 

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
        Write-Host "Your operating system is:" $hostOs
        throw "Sorry but this script only works on Windows."
    }
}

function GetComputerName()
{
    Write-Host "`nGet computer name on Windows.`n"
    CheckOsForWindows
    
    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started getting computer name at" $startDateTime.DateTime

        $hostName = $Env:COMPUTERNAME     
        Write-Host "The computer name is:" $hostName -ForegroundColor Blue
        Write-Host "Successfully got computer name." -ForegroundColor Green
        
        $finishedDateTime = (Get-Date)
        Write-Host "Finished getting computer name at" $finishedDateTime.DateTime
        
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch 
    {
        Write-Host "Failed getting your computer name.`n" -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

GetComputerName
