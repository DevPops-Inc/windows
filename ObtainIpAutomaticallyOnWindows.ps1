# obtain IP address automatically on Windows

# you can run this script with: ObtainIpAutomaticallyOnWindows.ps1 -ipType < IPv4 or IPv6 > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $ipType = ""
)

function GetIpType([string]$ipType)
{
    if (($ipType -eq $Null) -or ($ipType -eq ""))
    {
        $iPType = Read-Host - Prompt "Please type which IP type you like to use (IPv4 or IPv6)?"

        return $ipType
    }
    else 
    {
        return $ipType
    }
}

function CheckOsForWindows()
{
    Write-Host "`nChecking operating system..."
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "You are running this script on Windows." -ForegroundColor Green
    }
    else 
    {
        Write-Host "Your operating system is:" $hostOs
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system.`n"
        break
    }
    Write-Host "Finished checking operating system.`n"
}

function ObtainIpAutomatically([string]$ipType)
{
    Write-Host "`nObtain IP address automatically on Windows.`n"
    CheckOsForWindows

    $ipType = GetIpType $ipType

    try 
    {
        $adapter = Get-NetAdapter | ? {$_.Status -eq "up"}
        $interface = $adapter | Get-NetIPInterface -AddressFamily $ipType
        
        # obtain IP address
        if ($interface.Dhcp -eq "Disabled") 
        {
            # Remove existing gateway
            if (($interface | Get-NetIPConfiguration).Ipv4DefaultGateway) 
            {
                $interface | Remove-NetRoute -Confirm:$false
            }
            # Enable DHCP
            $interface | Set-NetIPInterface -DHCP Enabled
            
            # Configure the DNS Servers automatically
            $interface | Set-DnsClientServerAddress -ResetServerAddresses

            Write-Host "Successfully obtained IP address automatically." -ForegroundColor Green
        }
    }
    catch 
    {
        Write-Host "Failed to obtain IP address automatically" -ForegroundColor Red
    }
}

ObtainIpAutomatically $ipType
