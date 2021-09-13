# disable password expiration for admin on windows

# you can run script with: .\DisablePwExpForAdminOnWindows.ps1 -localAdmin < local admin > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $localAdmin = ""
)

function CheckOsForWindows()
{
    Write-Host "`nStarted checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
    }
    else
    {
        Write-Host "Operating System:" $hostOs
        
        Write-Host "Sorry but this script only works in Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
    }
}

function GetLocalAdmin([string]$localAdmin)
{
    if (($localAdmin -eq $Null) -or ($localAdmin -eq ""))
    {
        Write-Host "`nThe users on this computer are: `n"
        Get-LocalUser 

        $localAdmin = Read-Host -Prompt "`nPlease type the admin who you would like to disable password expiration for and press `"Enter`" key (Example: Local.Admin)"
        
        return $localAdmin
    }
    else
    {
        return $localAdmin
    }
}

function CheckParameters([string]$localAdmin)
{
    Write-Host "`nStarted checking parameters at" (Get-Date).DateTime
    $valid = $True

    Write-Host "`nParameters:"
    Write-Host "----------------------------------------"
    Write-Host ("localAdmin: {0}" -F $localAdmin)
    Write-Host "----------------------------------------"

    if (($localAdmin -eq $Null) -or ($localAdmin -eq ""))
    {
        Write-Host "localAdmin is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter checks passed.`n" -ForegroundColor Green
    }
    else 
    {
        Write-Host "One or more parameters are incorrect, exiting script." -ForegroundColor Red
        
        exit -1
    }
}

function DisablePwExpForAdmin([string]$localAdmin)
{
    Write-Host "`nDisable password expiration for admin on Windows.`n"
    CheckOsForWindows

    $localAdmin = GetLocalAdmin $localAdmin
    CheckParameters $localAdmin

    try
    {
        $startDatetime = (Get-Date)
        Write-Host "Started disabling password expiration for admin at" $startDatetime

        Set-LocalUser -Name "$localAdmin" -PasswordNeverExpires 1
     
        Write-Host ("`nSucceessfully disabled password expiration for admin: {0}.`n" -F $localAdmin) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished disabling password expiration for admin at" $finishedDateTime
        $duration = New-TimeSpan $startDatetime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch
    {
        Write-Host ("`nFailed to disable password expiration for admin: {0}.`n" -F $localAdmin) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

DisablePwExpForAdmin $localAdmin
