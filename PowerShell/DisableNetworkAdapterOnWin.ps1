# disable network adapter on Windows 

# you can run this script with: .\DisableNetworkAdapterOnWin.ps1 -networkAdapter < network adapter >

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
        Write-Host "The current network adapters on this computer are: "
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
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "----------------------------------------"
    Write-Host ("networkAdapter: {0}" -F $networkAdapter)
    Write-Host "----------------------------------------"

    if (($networkAdapter -eq $Null) -or ($networkAdapter -eq ""))
    {
        Write-Host "networkAdapter is not set." -ForegroundColor Red
        $valid = $False
    }

    Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime

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

function DisableNetworkAdapter([string]$networkAdapter)
{
    Write-Host "`nDisable network adapter on Windows.`n"
    CheckOsForWindows

    $networkAdapter = GetNetworkAdapter $networkAdapter
    CheckParameters $networkAdapter

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started disabling network adapter at" $startDateTime.DateTime

        Disable-NetAdapter -Name $networkAdapter -Confirm:$false

        Write-Host ("Successfully disabled {0} network adapter." -F $networkAdapter) -ForegroundColor Green

        Write-Host "The network adapters on this computer are: "
        Get-NetAdapter | Format-Table

        $finishedDateTime = (Get-Date)
        Write-Host "Finished disabling network adapter at" $finishedDateTime.DateTime
        
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch 
    {
        Write-Host ("Failed to disable {0} network adapter." -F $networkAdapter) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red

        Write-Host "The network adapters on this computer are: "
        Get-NetAdapter | Format-Table
    }
}

DisableNetworkAdapter $networkAdapter
