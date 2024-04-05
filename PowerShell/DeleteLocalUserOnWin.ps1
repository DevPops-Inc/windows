# delete local user on Windows 

# run this script as admin: Start-Process PowerShell -Verb RunAs
# you can run this script with: .\DeleteLocalUserOnWin.ps1 -localUser < local user >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $localUser = "" # you can set the username here
)

function CheckOsForWin()
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
        throw "Sorry but this script only works in Windows."
    }
}

function GetLocalUser([string]$localUser)
{
    if (($localUser -eq $Null) -or ($localUser -eq ""))
    {
        Get-LocalUser | Out-String
        
        $localUser = Read-Host -Prompt "Please type the local user you would like to delete and press the `"Enter`" key (Example: LocalUser)"

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
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
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
        Write-Host "All parameter check(s) passed." -ForegroundColor Green

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
    }
    else
    {
        throw "One or more parameters are incorrect." 
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
        Write-Host ("Started deleting {0} at {1}" -F $localUser, $startDateTime.DateTime)

        Remove-LocalUser -Name "$localUser" 
        Write-Host "The users on this computer are:" (Get-LocalUser) -ForegroundColor Blue
        Write-Host ("Successfully deleted {0}" -F $localUser) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host ("Finished deleting {0} at {1}" -F $localUser, $finishedDateTime.DateTime)
        
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
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
