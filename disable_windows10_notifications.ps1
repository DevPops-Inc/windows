# disable Window 10 Notifications

# prompt user input
Write-Host "`nDisable Windows 10 notifications."
Pause

# declare disableNotificationsInWinReg and windows10 variables and foreach lopp
$disableNotificationsInWinReg =
{
    Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -Type DWord -Value 1

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Type DWord -Value 0
}

$windows10 = Get-ADComputer -Filter {OperatingSystem -Like '*Windows 10*' } | Select-Object -ExpandProperty Name

Foreach($win in $windows10)
{
    Invoke-Command -ComputerName $win10 -ScriptBlock $disableNotificationsInWinReg
}
