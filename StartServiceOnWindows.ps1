# start service on Windows 

# you can run this script with: .\StartServiceOnWindows.ps1 -serviceName < service > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $serviceName = ""
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
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        break
    }
}

function GetServiceName([string]$serviceName)
{
    if (($serviceName -eq $Null) -or ($serviceName -eq ""))
    {
        $serviceName = Read-Host -Prompt "Please type the service you wish to start and press `"Enter`" key (Example: XboxNetApiSvc)"

        Write-Host ""
        return $serviceName
    }
    else
    {
        return $serviceName
    }
}

function CheckParameters([string]$serviceName)
{
    Write-Host "Started checking parameters at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameters:"
    Write-Host "-----------------------------------"
    Write-Host ("serviceName: {0}" -F $serviceName)
    Write-Host "-----------------------------------"

    if (($serviceName -eq $Null) -or ($serviceName -eq ""))
    {
        Write-Host "serviceName is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter checks passed." -ForegroundColor Green
    }
    else 
    {
        Write-Host "One or more parameters are incorrect, exiting script." -ForegroundColor Red

        exit -1
    }

    Write-Host "Finished checking parameters at" (Get-Date).DateTime
    Write-Host ""
}

function StartService([string]$serviceName)
{
    Write-Host "`nStart Service on Windows.`n"
    CheckOsForWindows

    Write-Host "The services on this computer are: "
    Get-Service 

    $serviceName = GetServiceName $serviceName
    CheckParameters $serviceName

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started service at" $startDateTime

        Start-Service $serviceName

        Write-Host ("Successfully started {0} service." -F $serviceName) -ForegroundColor Green

        Get-Service -Name $serviceName

        $finishedDateTime = (Get-Date)
        Write-Host "Finished starting service at" $finishedDateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
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
