# enable local admin on Windows 

# prompt user input 
Write-Host "`nEnable local Administrator account on Windows."
Pause

# enable local admin 
Get-LocalUser -Name "Administrator" | Enable-LocalUser
