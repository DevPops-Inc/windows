# stop service on Windows

# run this script as admin: Start-Process PowerShell -Verb RunAs
# you can run this script with: .\StopServiceOnWindows.ps1 -serviceName < service > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $serviceName = ""
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

function GetServiceName([string]$serviceName)
{
    if (($Null -eq $serviceName) -or ($serviceName -eq ""))
    {
        $serviceName = Read-Host -Prompt "Please type the service you wish to stop and press the `"Enter`" key (Example: XboxNetApiSvc)"

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
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-----------------------------------"
    Write-Host ("serviceName: {0}" -F $serviceName)
    Write-Host "-----------------------------------"

    if (($Null -eq $serviceName) -or ($serviceName -eq ""))
    {
        Write-Host "serviceName is not set." -ForegroundColor Red
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

function StopService([string]$serviceName)
{
    Write-Host "`nStop Service on Windows.`n"
    CheckOsForWin

    Write-Host "The services on this computer are: "
    Get-Service | Format-Table -AutoSize
    
    $serviceName = GetServiceName $serviceName
    CheckParameters $serviceName

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host ("Started stopping {0} at {1}" -F $serviceName, $startDateTime.DateTime)

        Stop-Service $serviceName
        Get-Service -Name $serviceName | Format-Table -AutoSize
        Write-Host ("Successfully stopped {0}" -F $serviceName) -ForegroundColor Green
        
        $finishedDateTime = (Get-Date)
        Write-Host ("Finished stopping {0} at {1}" -F $serviceName, $finishedDateTime.DateTime)

        $duration = New-TimeSpan $startDateTime $finishedDateTime
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
        Write-Host ""
    }
    catch 
    {
        Write-Host ("Failed to start {0} service." -F $serviceName) -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""

        Write-Host "The services on this computer are:"
        Get-Service | Format-Table -AutoSize
    }
}

StopService $serviceName
