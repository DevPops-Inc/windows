# remove user from Active Directoy

# you can run this script with: .\RemoveUserFromActiveDirectory.ps1 -username < username >

[CmdletBinding()]
param(
    [string] [Parameters(Mandatory = $False)] $username = ""
)

function GetUsername([string]$username)
{
    if (($username -eq $Null) -or ($username -eq ""))
    {
        $username = Read-Host -Prompt "Please type the user would you like to remove from Active Directory and press `"Enter`" key (Example: software.developer)"

        return $username
    }
    else
    {
        return $username
    }
}

function CheckOsForWindows()
{
    Write-Host "`nChecking operating system..."
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green
    }
    else 
    {
        Write-Host "Your operating system is:" $hostOs
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system.`n"
        break
    }
    Write-Host "Finished checking operating system.`n"
}

function RemoveUserFromAd([string]$username)
{
    Write-Host "`nRemove user from Active Directory.`n"
    CheckOsForWindows

    $username = GetUsername $username

    try 
    {
        Remove-ADGroupMember -Identity $username -force

        Write-Host ("Successfully removed {0} from Active Directory." -F $username) -ForegroundColor Green
    }
    catch 
    {
        Write-Host ("Failed to remove {0} from Active Directory" -F $username) -ForegroundColor Red
    }
}

RemoveUserFromAd $username
