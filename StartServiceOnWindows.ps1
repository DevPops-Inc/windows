# start service on Windows 

# you can run this script with: .\StartServiceOnWindows.ps1 -serviceName < service > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $serviceName = ""
)

function GetServiceName([string]$serviceName)
{
    if (($serviceName -eq $Null) -or ($serviceName -eq ""))
    {
        $serviceName = Read-Host -Prompt "Please type the service you wish to start (Example: XboxNetApiSvc)"

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

function StartService()
{
    Write-Host "`nStart Service on Windows.`n"
    CheckOsForWindows

    Write-Host "The services on this computer are: "
    Get-Service 

    $serviceName = GetServiceName $serviceName

    try 
    {
        Start-Service $serviceName

        Write-Host ("Successfully started {0} service." -F $serviceName) -ForegroundColor Green

        Get-Service -Name $serviceName
    }
    catch
    {
        Write-Host ("Failed to start {0} service." -F $serviceName) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red

        Write-Host "The services on this computer are: "
        Get-Service         
    }
}

StartService $serviceName
