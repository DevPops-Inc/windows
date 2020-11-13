#!/bin/powershell

# Windows maintenance function

# you need to elevaate permissions before this function can run: 
# Start-Process Powershell -Verb runAs 

# define function
function Windows-Maintenance {
    Write-Output y | chkdsk /f/r c:
    SFC /scannow
    Dism /Online /Cleanup-Image /ScanHealth
    defrag c: /u
    Write-Output "Please save your documents and close applications."
    pause
    shutdown /r /0
}

# call function
Windows-Maintenance
