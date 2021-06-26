# enable local admin on Windows 

function EnableLocalAdmin()
{
    Write-Host "`nEnable local Administrator account on Windows.`n"

    try 
    {
        Get-LocalUser -Name "Administrator" | Enable-LocalUser

        Write-Host "`nSuccessfully enabled local Administrator account." -ForegroundColor Green
    }
    catch
    {
        Write-Host "`nFailed to enable local Administrator account.`n" -ForegroundColor Red
    }
}

EnableLocalAdmin
