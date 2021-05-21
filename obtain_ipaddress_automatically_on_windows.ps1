# obtain IP address automatically on Windows

# prompt user input
Write-Host "`nObtain IP address automatically on Windows."
Pause

# declare ipType, adapter, and interface variables 
$iPType = Read-Host - Prompt "`nWhich adapter would you like to use (IPv4 or IPv6)?"
$adapter = Get-NetAdapter | ? {$_.Status -eq "up"}
$interface = $adapter | Get-NetIPInterface -AddressFamily $iPType

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
}
