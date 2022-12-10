# disable password expiration for admin on windows

# you can run script with: .\DisablePwExpForAdminOnWindows.ps1 -localAdmin < local admin > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $localAdmin = ""
)

function CheckOsForWindows()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
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

        break
    }
}

function GetLocalAdmin([string]$localAdmin)
{
    if (($localAdmin -eq $Null) -or ($localAdmin -eq ""))
    {
        Write-Host "The users on this computer are: "
        Get-LocalUser 

        $localAdmin = Read-Host -Prompt "Please type the admin who you would like to disable password expiration for and press `"Enter`" key (Example: Local.Admin)"
        
        return $localAdmin
    }
    else
    {
        return $localAdmin
    }
}

function CheckParameters([string]$localAdmin)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "---------------------------------"
    Write-Host ("localAdmin: {0}" -F $localAdmin)
    Write-Host "---------------------------------"

    if (($localAdmin -eq $Null) -or ($localAdmin -eq ""))
    {
        Write-Host "localAdmin is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter check(s) passed." -ForegroundColor Green

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "One or more parameters are incorrect." -ForegroundColor Red
        
        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""

        break
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
        Write-Host "Started disabling password expiration for admin at" $startDateTime.DateTime

        Set-LocalUser -Name "$localAdmin" -PasswordNeverExpires 1
     
        Write-Host ("Succeessfully disabled password expiration for admin: {0}." -F $localAdmin) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished disabling password expiration for admin at" $finishedDateTime.DateTime
        $duration = New-TimeSpan $startDatetime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host ("Failed to disable password expiration for admin: {0}." -F $localAdmin) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

DisablePwExpForAdmin $localAdmin
