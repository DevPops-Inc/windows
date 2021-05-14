# enable Windows Subsystem for Linux (WSL)

# prompt user input
Write-Host "`nEnable Windows Subsystem for Linux."
Pause

# define and call enableWSL function
function enableWsl()
{
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -Force
}

enableWsl
