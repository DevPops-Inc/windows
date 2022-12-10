# disable Window 10 Notifications

function CheckOsForWindows()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_Operating.System).Caption -ForegroundColor Green

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

$disableNotificationsInWinReg =
{
    Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -Type DWord -Value 1

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Type DWord -Value 0
}

$windows10 = Get-ADComputer -Filter { OperatingSystem -Like '*Windows 10*' } | Select-Object -ExpandProperty Name

function DisableWindows10Notifications()
{
    Write-Host "`nDisable Windows 10 notifications.`n"
    CheckOsForWindows

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started disabling Windows 10 notifications at" $startDateTime.DateTime

        foreach($win in $windows10)
        {
            Invoke-Command -ComputerName $win10 -ScriptBlock $disableNotificationsInWinReg
        }

        Write-Host "Successfully disabled Windows 10 notifications." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished disabling Windows 10 notifications at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime
        
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host "Failed to disable Windows 10 notifications." -Foreground Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

DisableWindows10Notifications
