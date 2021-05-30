# stop process on Windows 

# prompt user input
Write-Host "`nStop process on Windows."
Pause

# list of processes
Get-Process

# declare variables
$processName = Read-Host -Prompt "`nPlease type the process you would like to stop (Example: outlook.exe): "

# define StopProcessOnWindows function
function StopProcessOnWindows()
{
    # stop process
    Stop-Process -processname $processName

    # get process status
    Get-Process -Name $processName
}

# call StopProcessOnWindows function
StopProcessOnWindows
