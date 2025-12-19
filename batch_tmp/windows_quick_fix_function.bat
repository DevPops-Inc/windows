rem Windows quick fix function

rem define function
:QuickFix
echo y | chkdsk /f c:
shutdown /r /t 0
EXIT /B 0

CALL :QuickFix
