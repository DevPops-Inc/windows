# delete local user on Windows 

# you can run this script with: .\DeleteLocalUserOnWindows.ps1 -localUser < local user >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $localUser = ""
)

function CheckOsForWindows()
{
    Write-Host "`nStarted checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Captain -ForegroundColor Green

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

function GetLocalUser([string]$localUser)
{
    if (($localUser -eq $Null) -or ($localUser -eq ""))
    {
        $localUser = Read-Host -Prompt "`nPlease type the local user you would like to delete and press `"Enter`" key (Example: LocalUser)"

        return $localUser
    }
    else
    {
        return $localUser
    }
}

function CheckParameters([string]$localUser)
{
    Write-Host "`nStarted checking parameters at" (Get-Date).DateTime
    $valid = $True

    Write-Host "`nParameters:"
    Write-Host "----------------------------------------"
    Write-Host ("localUser: {0}" -F $localUser)
    Write-Host "----------------------------------------"

    if (($localUser -eq $Null) -or ($localUser -eq ""))
    {
        Write-Host "localUser is not set." -ForegroundColor -Red
        $valid = $False
    }

    Write-Host "Finished checking parameters at" (Get-Date).DateTime

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

function DeleteLocalUser([string]$localUser)
{
    Write-Host "`nDelete local user on Windows.`n"
    CheckOsForWindows

    $localUser = GetLocalUser $localUser
    CheckParameters $localUser

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started deleting local user at" $startDateTime

        Remove-LocalUser -Name "$localUser"

        Write-Host ("`nSuccesffully delete local user: {0}`n" -F $localUser) -ForegroundColor Green

        Write-Host "`nThe users on this computer are: `n"
        Get-LocalUser

        $finishedDateTime = (Get-Date)
        Write-Host "Finished deleting local user at" $finishedDateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch
    {
        Write-Host ("`nFailed to delete local user: {0}." -F $localUser) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red

        Write-Host "`nThe users on this computer are: `n"
        Get-LocalUser
    }
}

DeleteLocalUser $localUser
