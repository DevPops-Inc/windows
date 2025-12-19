rem get programs on Windows

:GetPrograms
echo "Started getting programs on Windows..." 
wmic product get name
echo "Finished getting programs on Windows."
EXIT /B 0

CALL :GetPrograms
