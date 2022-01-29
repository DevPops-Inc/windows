# delete local user on Windows 

# you can run this script with: .\DeleteLocalUserOnWindows.ps1 -localUser < local user >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $localUser = "" # you can set the username here
)

function CheckOsForWindows()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
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
        $localUser = Read-Host -Prompt "Please type the local user you would like to delete and press `"Enter`" key (Example: LocalUser)"

        Write-Host ""
        return $localUser
    }
    else
    {
        return $localUser
    }
}

function CheckParameters([string]$localUser)
{
    Write-Host "Started checking parameters at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameters:"
    Write-Host "-------------------------------"
    Write-Host ("localUser: {0}" -F $localUser)
    Write-Host "-------------------------------"

    if (($localUser -eq $Null) -or ($localUser -eq ""))
    {
        Write-Host "localUser is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter checks passed." -ForegroundColor Green
    }
    else
    {
        Write-Host "One or more parameters are incorrect." -ForegroundColor Red
        break
    }

    Write-Host "Finished checking parameters at" (Get-Date).DateTime
    Write-Host ""
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
        
        Write-Host ("Successfully deleted local user: {0}`n" -F $localUser) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished deleting local user at" $finishedDateTime
        
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""

        Write-Host "The users on this computer are:"
        Get-LocalUser
    }
    catch
    {
        Write-Host ("Failed to delete local user: {0}." -F $localUser) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red

        Write-Host "The users on this computer are:"
        Get-LocalUser
    }
}

DeleteLocalUser $localUser
