# open photo on Windows

# prompt user input
Write-Host "`nOpen photo on Windows."
Pause

# declare photoLocation variable
$photoLocation = Read-Host -Prompt "Please type location of photo you wish to open (Example: C:\$env:USERNAME\Desktop\photo.jpg): "

# open photo 
Start-Process -Path $photoLocation
