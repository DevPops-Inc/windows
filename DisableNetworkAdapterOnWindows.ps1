# disable network adapter on Windows 

# you can run this script with: .\DisableNetworkAdapterOnWindows.ps1 -networkAdapter < network adapter >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $networkAdapter = ""
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

function GetNetworkAdapter([string]$networkAdapter)
{
    if (($networkAdapter -eq $Null) -or ($networkAdapter -eq ""))
    {
        Write-Host "`nThe current network adapters on this computer are: `n"
        Get-NetAdapter | Format-Table

        $networkAdapter = Read-Host -Prompt "Please type the network adapter you want to disable and press `"Enter`" key"

        return $networkAdapter
    }
    else
    {
        return $networkAdapter
    }
}

function CheckParameters([string]$networkAdapter)
{
    Write-Host "`nStarted checking parameters at" (Get-Date).DateTime
    $valid = $True

    Write-Host "`nParameters:"
    Write-Host "----------------------------------------"
    Write-Host ("networkAdapter: {0}" -F $networkAdapter)
    Write-Host "----------------------------------------"

    if (($networkAdapter -eq $Null) -or ($networkAdapter -eq ""))
    {
        Write-Host "networkAdapter is not set." -ForegroundColor Red
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

function DisableNetworkAdapter([string]$networkAdapter)
{
    Write-Host "`nDisable network adapter on Windows.`n"
    CheckOsForWindows

    $networkAdapter = GetNetworkAdapter $networkAdapter
    CheckParameters $networkAdapter

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started disabling network adapter at" $startDateTime

        Disable-NetAdapter -Name $networkAdapter -Confirm:$false

        Write-Host ("`nSuccessfully disabled {0} network adapter.`n" -F $networkAdapter) -ForegroundColor Green

        Write-Host "The network adapters on this computer are: `n"
        Get-NetAdapter | Format-Table

        $finishedDateTime = (Get-Date)
        Write-Host "Finished disabling network adapter at" $finishedDateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host ("`nFailed to disable {0} network adapter.`n" -F $networkAdapter) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red

        Write-Host "The network adapters on this computer are: `n"
        Get-NetAdapter | Format-Table
    }
}

DisableNetworkAdapter $networkAdapter
