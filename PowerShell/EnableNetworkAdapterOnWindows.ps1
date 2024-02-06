# enable network adapter on Windows

# you can run this script with: .\EnableNetworkAdapterOnWindows.ps1 -networkAdapater < network adapter >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $networkAdapter = "" # you can set the network adapter here
)

function CheckOsForWindows()
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
        Write-Host "Sorry but this script only runs in Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        break 
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

    $networkAdapter = GetNetworkAdapter $networkAdapter

    try
    {
        Enable-NetAdapter -Name $networkAdapter -Confirm:$false

        Write-Host ("`nSuccessfully enabled {0} network adapter.`n" -F $networkAdapter) -ForegroundColor Green
        
        Get-NetAdapter -Name $networkAdapter
    }
    catch 
    {
        Write-Host ("`nFailed to enable {0} network adapter.`n" -F $networkAdapter) -ForegroundColor Red

        Get-NetAdapter -Name $networkAdapter
    }
}

EnableNetworkAdapter $networkAdapter
