# disable network adapter on Windows 

# you can run this script with: .\DisableNetworkAdapterOnWindows.ps1 -networkAdapter < network adapter >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $networkAdapter = ""
)

function GetNetworkAdapter([string]$networkAdapter)
{
    if (($networkAdapter -eq $Null) -or ($networkAdapter -eq ""))
    {
        Write-Host "`nThe current network adapters on this computer are: `n"
        
        # get network adapters names and statuses
        Get-NetAdapter | Format-Table

        $networkAdapter = Read-Host -Prompt "Please type the network adapter you want to do disable"

        return $networkAdapter
    }
    else
    {
        return $networkAdapter
    }
}

function DisableNetworkAdapter([string]$networkAdapter)
{
    Write-Host "`nDisable network adapter on Windows.`n"

    $networkAdapter = GetNetworkAdapter $networkAdapter

    try 
    {
        Disable-NetAdapter -Name $networkAdapter -Confirm:$false

        Write-Host ("`nSuccessfully disabled {0} network adapter.`n" -F $networkAdapter) -ForegroundColor Green

        Write-Host "The network adapters on this computer are: `n"
        Get-NetAdapter | Format-Table
    }
    catch 
    {
        Write-Host ("`nFailed to disable {0} network adapter.`n" -F $networkAdapter) -ForegroundColor Red

        Write-Host "The network adapters on this computer are: `n"
        Get-NetAdapter | Format-Table
    }
}

DisableNetworkAdapter $networkAdapter
