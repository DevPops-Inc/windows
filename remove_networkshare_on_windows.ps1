# remove network share on Windows 

# prompt user input
Write-Host "`nRemove network share on Windows."
Pause

# get list of drives
Get-PSDrive

# declare variables
$driveLetter = Read-Host -Prompt "`nPlease type the letter for the network share you would like to remove (Example: D): "

# define RemoveNetworkShareOnWindows function
function RemoveNetworkShareOnWindows()
{
    # remove mapped network share
    Remove-PSDrive -Name $driveLetter

    # get list of drives
    Get-PSDrive
}
