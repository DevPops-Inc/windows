# obtain automtic IP address on Windows

# you can run this script with: ObtainAutoIpOnWin.ps1 -ipType < IPv4 or IPv6 > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $ipType = "" # you can set IPv4 or IPv6 here 
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
        throw "Sorry but this script only works on Windows." 
    }
}


function GetIpType([string]$ipType)
{
    if (($Null -eq $ipType) -or ($ipType -eq ""))
    {
        $iPType = Read-Host -Prompt "Please type which IP type you like to use and press `"Enter`" key (IPv4 or IPv6)?"

        Write-Host ""
        return $ipType
    }
    else 
    {
        return $ipType
    }
}

function CheckParameters([string]$ipType)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-------------------------"
    Write-Host ("ipType: {0}" -F $ipType)
    Write-Host "-------------------------"

    if (($Null -eq $ipType) -or ($ipType -eq ""))
    {
        Write-Host "ipType is not set." -ForegroundColor Red
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
        throw "One or more parameters are incorrect, exiting script." 
    }
}

function ObtainAutoIp([string]$ipType)
{
    Write-Host "`nObtain automatic IP address on Windows.`n"
    CheckOsForWin

    $ipType = GetIpType $ipType
    CheckParameters $ipType

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started optaining automatic IP address at" $startDateTime.DateTime

        $adapter = Get-NetAdapter | Where-Object {$_.Status -eq "up"}
        $interface = $adapter | Get-NetIPInterface -AddressFamily $ipType
        
        if ($interface.Dhcp -eq "Disabled") 
        {
            if (($interface | Get-NetIPConfiguration).Ipv4DefaultGateway) 
            {
                $interface | Remove-NetRoute -Confirm:$false
            }

            $interface | Set-NetIPInterface -DHCP Enabled
            $interface | Set-DnsClientServerAddress -ResetServerAddresses
        }

        $ipAddress = ($interface | Get-NetIPAddress).IPAddress
        Write-Host ("IP Address: {0}" -F $ipAddress) -ForegroundColor Blue
        Write-Host "Successfully obtained automatic IP address." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished obtaining automatic IP address at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
        
        Write-Host ""
    }
    catch 
    {
        Write-Host "Failed to obtain automatic IP address." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

ObtainAutoIp $ipType
