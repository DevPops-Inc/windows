# enable local admin on Windows 

function CheckOsForWindows()
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
        Write-Host "Sorry but this script only works in Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        break
    }
}

function EnableLocalAdmin()
{
    Write-Host "`nEnable local Administrator account on Windows.`n"
    CheckOsForWindows

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started enabling local Administrator account at" $startDateTime.DateTime

        Get-LocalUser -Name "Administrator" | Enable-LocalUser
        Write-Host "Successfully enabled local Administrator account." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished enabling local Administrator account at" $finishedDateTime.DateTime
        
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host "Failed to enable local Administrator account." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

EnableLocalAdmin
