# check disk on Windows

# prompt user input
Write-Host "`nCheck disk on Windows."
Pause

# check disk and repair C drive
Write-Output y | chkdsk /f/r c:
