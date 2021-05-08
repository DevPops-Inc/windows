# open photo in Paint 3D on Windows

# prompt user input 
Write-Host "`nOpen photo in Paint 3D on Windows."
Pause

# declare FileLocation variable and set it to file location
$FileLocation = Read-Host -Prompt "`nWhat is location of the file? (Example: C:\Users\adminvictor\Desktop\deltatre 2019.jpg)`n"

# open file with Paint 3D
Start-Process -FilePath "mspaint" -ArgumentList """$FileLocation /ForceBootstrapPaint3D"""
