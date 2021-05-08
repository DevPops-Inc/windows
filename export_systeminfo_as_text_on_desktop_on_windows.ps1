# export system info to text file on desktop

# prompt user input
Write-Host "`nExport system info to text file on desktop on Windows."
Pause

systeminfo | Out-File C:\Users\$env:username\Desktop\systeminfo.txt
