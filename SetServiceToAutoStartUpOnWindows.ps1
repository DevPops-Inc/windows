# set service to automatic startup on Windows 

# run this script with: .\SetSetToAutoStartUpOnWindows.ps1 -serviceName < service name >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $serviceName = ""
)

function GetServiceName([string]$serviceName)
{
    if (($serviceName -eq $Null) -or ($serviceName -eq ""))
    {
        $serviceName = Read-Host -Prompt "Please type the service you wish to set to automatic start up and press `"Enter`" key (Example: XboxNetApiSvc)"

        return $serviceName
    }
    else
    {
        return $serviceName
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
        Write-Host "Operating System:" $hostOs
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system.`n"
        break
    }
    Write-Host "Finished checking operating system.`n"
}

function SetServiceToAutoStart([string]$serviceName)
{
    Write-Host "`nSet service to automatic startup on Windows.`n"
    CheckOsForWindows

    Write-Host "Services running on this computer are:"
    Get-Service

    $serviceName = GetServiceName $serviceName

    try 
    {
        Set-Service $serviceName -StartupType Automatic

        Write-Host ("Successfully set {0} to automatically startup." -F $serviceName) -ForegroundColor Green

        Get-Service -Name $serviceName
    }
    catch
    {
        Write-Host ("Failed to set {0} to automatically startup." -F $serviceName) -ForegroundColor Red
    }
}

SetServiceToAutoStart $serviceName
