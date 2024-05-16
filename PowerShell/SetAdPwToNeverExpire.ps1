# set Active Directory password to never expire

# you can run this script with: .\SetAdPwToNeverExpire.ps1 -adUser < username >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $adUser = ""
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
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        break
    }
}

function GetAdUser([string]$adUser)
{
    if (($adUser -eq $Null) -or ($adUser -eq ""))
    {
        $adUser = Read-Host -Prompt "Please type the username whose password you wish to never expire and press `"Enter`" key (Example: AD.User)"

        Write-Host ""
        return $adUser
    }
    else
    {
        return $adUser
    }
}

function CheckParameters([string]$adUser)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-------------------------"
    Write-Host ("adUser: {0}" -F $adUser)
    Write-Host "-------------------------"

    if (($adUser -eq $Null) -or ($adUser -eq ""))
    {
        Write-Host "adUser is not set." -ForegroundColor Red
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter check(s) passed." -ForegroundColor Green
    }
    else 
    {
        Write-Host "One or more parameter checks are incorrect, exiting script." -ForegroundColor Red

        exit -1
    }

    Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
    Write-Host ""
}

function SetPwToNeverExpireInAd([string]$adUser)
{
    Write-Host "`nSet password to never expire on Active Directory.`n"
    CheckOsForWin

    $adUser = GetAdUser $adUser
    CheckParameters $adUser

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started setting password to never expire at" $startDateTime.DateTime

        Set-LocalUser -Name "$adUser" -PasswordNeverExpires 1
        
        Write-Host ("Successfully set password to never expire for {0}." -F $adUser) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        
        Write-Host "Finished setting password to never expire at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch
    {
        Write-Host ("Failed to set password to never expire for {0}." -F $adUser) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

SetPwToNeverExpireInAd $adUser
