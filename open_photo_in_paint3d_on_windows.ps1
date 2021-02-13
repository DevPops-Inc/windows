#!/bin/powershell 

# open photo in Paint 3D on Windows

# declare variable and set it to file location
$FileLocation = "C:\Users\adminvictor\Desktop\deltatre 2019.jpg"

# open file with Paint 3D
Start-Process -FilePath "mspaint" -ArgumentList """$FileLocation /ForceBootstrapPaint3D"""
