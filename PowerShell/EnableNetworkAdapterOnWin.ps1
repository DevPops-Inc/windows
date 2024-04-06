# enable network adapter on Windows

# you can run this script with: .\EnableNetworkAdapterOnWin.ps1 -networkAdapater < network adapter >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $networkAdapter = "" # you can set the network adapter here
)

function CheckOsForWin()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "Operating System:" $hostOs
        throw "Sorry but this script only runs in Windows." 
    }
}

function GetNetworkAdapter([string]$networkAdapter)
{
    if (($networkAdapter -eq $Null) -or ($networkAdapter -eq ""))
    {
        Write-Host "The network adapters on this computer are:"
        Get-NetAdapter | Format-Table

        $networkAdapter = Read-Host -Prompt "`nPlease type the network adapter would you like to enable (Example: Ethernet)"

        Write-Host ""
        return $networkAdapter
    }
    else 
    {
        return $networkAdapter
    }
}

function EnableNetworkAdapter([string]$networkAdapter)
{
    Write-Host "`nEnable network adapter on Windows.`n"
    CheckOsForWin

    $networkAdapter = GetNetworkAdapter $networkAdapter

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started enabling network adapter at" $startDateTime.DateTime

        Enable-NetAdapter -Name $networkAdapter -Confirm:$false

        Write-Host ("Successfully enabled {0} network adapter.`n" -F $networkAdapter) -ForegroundColor Green
        
        Get-NetAdapter -Name $networkAdapter

        $finishedDateTime = (Get-Date)
        Write-Host "Finished enabling network adapter at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime
        
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $durations.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch 
    {
        Write-Host ("`nFailed to enable {0} network adapter.`n" -F $networkAdapter) -ForegroundColor Red

        Get-NetAdapter -Name $networkAdapter
        Write-Host $_. -ForegroundColor
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

EnableNetworkAdapter $networkAdapter
