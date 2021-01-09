#!/bin/powershell

# stop and relaunch Outlook function on Windows

# declare variables
$ProcessName = 'OUTLOOK'
$Seconds = 5
$ApplicationName = 'outlook.exe'

# define function
function Stop-Relaunch-Outlook {
    Stop-Process -processname $ProcessName
    Start-Sleep -s $Seconds
    Start-Process -FilePath $ApplicationName
}

# call function
Stop-Relaunch-Outlook
