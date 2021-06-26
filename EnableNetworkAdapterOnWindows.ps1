# enable network adapter on Windows

# you can run this script with: .\EnableNetworkAdapterOnWindows.ps1 -networkAdapater < network adapter >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $networkAdapter = ""
)

function GetNetworkAdapter([string]$networkAdapter)
{
    if (($networkAdapter -eq $Null) -or ($networkAdapter -eq ""))
    {
        Write-Host "`nThe network adapters on this computer are: `n"
        Get-NetAdapter | Format-Table

        $networkAdapter = Read-Host -Prompt "`nPlease type the network adapter would you like to enable (Example: Ethernet)"

        return $networkAdapter
    }
    else 
    {
        return $networkAdapter
    }
}

function EnableNetworkAdapter([string]$networkAdapter)
{
    Write-Host "`nEnable network adapter on Windows`n"

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
