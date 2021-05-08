# check disk and restart on Windows

# prompt user input
Write-Host "`nCheck disk and restart on Windows."
Pause

# enable check disk and repair on C drive upon restart
Write-Output y | chkdsk /f/r c:

# prompt user to save documents and close applications before restart
Write-Host "`nPlease save your documents and close applications."
Pause

# restart computer
shutdown /r /t 0
