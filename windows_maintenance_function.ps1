# Windows maintenance function

# prompt user input 
Write-Host "`nWindows maintenance function.`nYou need to elevate permissions before this function can run: Start-Process Powershell -Verb runAs"
Pause

# define WindowsMaintenance function
function WindowsMaintenance()
{
    Write-Output y | chkdsk /f/r c:
    SFC /scannow
    Dism /Online /Cleanup-Image /ScanHealth
    defrag c: /u
    Write-Output "`nPlease save your documents and close applications.`n"
    Pause
    shutdown /r /t 0
}

# call WindowsMaintenance function
WindowsMaintenance
