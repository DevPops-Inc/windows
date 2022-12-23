# remove user from Active Directoy

# you can run this script with: .\RemoveUserFromActiveDirectory.ps1 -username '< username >'

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $username = "" # you can set the username here
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
        Write-Host "Your operating system is:" $hostOs
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""

        break
    }
}

function GetUsername([string]$username)
{
    if (($username -eq $Null) -or ($username -eq ""))
    {
        $username = Read-Host -Prompt "Please type the user would you like to remove from Active Directory and press the `"Enter`" key (Example: software.developer)"

        Write-Host ""
        return $username
    }
    else
    {
        return $username
    }
}

function CheckParameters([string]$username)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-----------------------------"
    Write-Host ("username: {0}" -F $username)
    Write-Host "-----------------------------"

    if (($username -eq $Null) -or ($username -eq ""))
    {
        Write-Host "username is not set." -ForegroundColor Red
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
        Write-Host "One or more parameter checks are incorrect, exiting script." -ForegroundColor Red

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""

        break
    }
}

function RemoveUserFromAd([string]$username)
{
    Write-Host "`nRemove user from Active Directory.`n"
    CheckOsForWindows

    $username = GetUsername $username
    CheckParameters $username

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started removing user at" $startDateTime.DateTime

        Remove-ADGroupMember -Identity $username -force

        Write-Host ("Successfully removed {0} from Active Directory." -F $username) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished removing user at" $finishedDateTime.DateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host ("Failed to remove {0} from Active Directory" -F $username) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

RemoveUserFromAd $username
