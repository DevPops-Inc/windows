# stop and relaunch Outlook function on Windows

# prompt user input
Write-Host "`nStop and relaunch Outlook function on Windows"
Pause

# declare processName, seconds, and applicationName variables
$processName = 'OUTLOOK'
$seconds = 5
$applicationName = 'outlook.exe'

# define StopAndRelaunchOutlook tfunction
function StopAndRelaunchOutlook()
{
    Stop-Process -ProcessName $processName
    Start-Sleep -s $seconds
    Start-Process -FilePath $applicationName
}

# call StopAndRelaunchOutlook function
StopAndRelaunchOutlook
