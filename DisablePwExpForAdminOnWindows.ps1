# disable password expiration for admin on windows

# you can run script with: .\DisablePwExpForAdminOnWindows.ps1 -localAdmin < local admin > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $localAdmin = ""
)

function GetLocalAdmin([string]$localAdmin)
{
    if (($localAdmin -eq $Null) -or ($localAdmin -eq ""))
    {
        Write-Host "`nThe users on this computer are: `n"
        Get-LocalUser 

        $localAdmin = Read-Host -Prompt "`nPlease type the admin who you would like to disable password expiration for (Example: Local.Admin)"
        return $localAdmin
    }
    else
    {
        return $localAdmin
    }
}

function DisablePwExpForAdmin([string]$localAdmin)
{
    Write-Host "`nDisable password expiration for admin on Windows.`n"

    $localAdmin = GetLocalAdmin $localAdmin

    try
    {
        Set-LocalUser -Name "$localAdmin" -PasswordNeverExpires 1
     
        Write-Host ("`nPassword expiration successfully disabled for {0}.`n" -F $localAdmin) -ForegroundColor Green
    }
    catch
    {
        Write-Host ("`nPassword expiration failed to disable for {0}.`n" -F $localAdmin) -ForegroundColor Red
    }
}

DisablePwExpForAdmin $localAdmin
