# restart printer spooler on Windows 

# prompt user input 
Write-Host "`nRestart printer spooler on Windows."
Pause 

# restart printer spooler
Restart-Service -Name Spooler -Force
