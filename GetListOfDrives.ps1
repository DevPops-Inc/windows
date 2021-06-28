# get list of drives

function GetListOfDrives()
{
    Write-Host "`nGet list of drives.`n"

    try 
    {
        Write-Host "`nSuccessfully got list of drives on this computer.`n" -ForegroundColor Green
        Get-PSDrive
    }
    catch 
    {
        Write-Host "`nFailed to get list of drives on this computer.`n" -Foreground Red
    }
}

GetListOfDrives
