# shutdown computer on Windows 

# prompt user input
Write-Host "`nShutdown computer on Windows."
Pause

# define ShutdownComputer function
function ShutdownComputer()
{
    # prompt user to save docs and close apps
    Write-Host "`nPlease save documents and close applications."
    Pause 

    # shutdown computer 
    Stop-Computer -ComputerName localhost
}

# call ShutdownComputer function 
ShutdownComputer
