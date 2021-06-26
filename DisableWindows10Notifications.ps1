# disable Window 10 Notifications

$disableNotificationsInWinReg =
{
    Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -Type DWord -Value 1

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Type DWord -Value 0
}

$windows10 = Get-ADComputer -Filter {OperatingSystem -Like '*Windows 10*' } | Select-Object -ExpandProperty Name

function DisableWindows10Notifications()
{
    Write-Host "`nDisable Windows 10 notifications.`n"

    try
    {
        foreach($win in $windows10)
        {
            Invoke-Command -ComputerName $win10 -ScriptBlock $disableNotificationsInWinReg
        }

        Write-Host "`nSuccessfully disabled Windows 10 notifications.`n" -ForegroundColor Green
    }
    catch
    {
        Write-Host "`nFailed to disable Windows 10 notifications.`n" -Foreground Red
    }
}

DisableWindows10Notifications
