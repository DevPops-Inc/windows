rem Windows maintenance function

rem define function
:Maintenance
echo y | chkdsk /f/r c:
SFC /scannow
Dism /Online /Cleanup-Image /ScanHealth
defrag c: /u
echo "Please save your work and close applications."
pause
shutdown /r /t 0
EXIT /B 0

CALL :Maintenance
