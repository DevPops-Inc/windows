# output list of Windows updates as text file on desktop

# prompt user input 
Write-Host "`nOutput list of Windows updates as text file onto desktop."
Pause

# output list of updates onto desktop
Get-Hotfix | Out-File C:\Users\$env:USERNAME\Desktop\windowsupdates.txt 
