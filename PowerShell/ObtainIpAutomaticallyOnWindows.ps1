# obtain IP address automatically on Windows

# you can run this script with: ObtainIpAutomaticallyOnWindows.ps1 -ipType < IPv4 or IPv6 > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $ipType = "" # you can set IPv4 or IPv6 here 
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


function GetIpType([string]$ipType)
{
    if (($ipType -eq $Null) -or ($ipType -eq ""))
    {
        $iPType = Read-Host -Prompt "Please type which IP type you like to use and press `"Enter`" key (IPv4 or IPv6)?"

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

    if (($ipType -eq $Null) -or ($ipType -eq ""))
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
        Write-Host "One or more parameters are incorrect, exiting script." -ForegroundColor Red

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""

        break
    }

    Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
}

function ObtainIpAutomatically([string]$ipType)
{
    Write-Host "`nObtain IP address automatically on Windows.`n"
    CheckOsForWindows

    $ipType = GetIpType $ipType
    CheckParameters $ipType

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started optaining IP address automatically at" $startDateTime.DateTime

        $adapter = Get-NetAdapter | ? {$_.Status -eq "up"}
        $interface = $adapter | Get-NetIPInterface -AddressFamily $ipType
        
        if ($interface.Dhcp -eq "Disabled") 
        {
            if (($interface | Get-NetIPConfiguration).Ipv4DefaultGateway) 
            {
                $interface | Remove-NetRoute -Confirm:$false
            }

            $interface | Set-NetIPInterface -DHCP Enabled
            $interface | Set-DnsClientServerAddress -ResetServerAddresses
            Write-Host "Successfully obtained IP address automatically." -ForegroundColor Green
        }

        $finishedDateTime = (Get-Date)
        Write-Host "Finished obtaining IP address automatically at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
        
        Write-Host ""
    }
    catch 
    {
        Write-Host "Failed to obtain IP address automatically" -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

ObtainIpAutomatically $ipType
