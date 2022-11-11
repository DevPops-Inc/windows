# ping loopback IPv6 address

# you can run this script: ./PingLoopBackIpv6AddressOnWindows.ps1 -loopBackIpv6Address < IPv6 addresss > 

[CmdletBinding()]
param(
    [System.Net.IPAddress] [Parameter(Mandatory = $False)] $loopBackIpv6Address = "::1"
)

function CheckOsForWindows()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green
    }
    else 
    {
        Write-Host "Operating System:" $hostOs -ForegroundColor Green
    }

    Write-Host "Finished checking operating system at" (Get-Date).DateTime
    Write-Host ""
}

function GetLoopBackIpv6Address([System.Net.IPAddress]$loopBackIpv6Address)
{
    if (($loopBackIpv6Address -eq $Null) -or ($loopBackIpv6Address -eq ""))
    {
        Read-Host -Prompt "Please type the loop back IPv6 address and press `"Enter`" key (Example: ::1)" 

        Write-Host ""
        return $loopBackIpv6Address
    }
    else 
    {
        return $loopBackIpv6Address
    }
}

function CheckParameters([System.Net.IPAddress]$loopBackIpv6Address)
{
    Write-Host "Started checking parameters at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameters:"
    Write-Host "---------------------------------------------------"
    Write-Host ("loopBackIpv6Address: {0}" -F $loopBackIpv6Address)
    Write-Host "---------------------------------------------------"

    if (($loopBackIpv6Address -eq $Null) -or ($loopBackIpv6Address -eq ""))
    {
        Write-Host "loopBackIpv4Address is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter checks passed." -ForegroundColor Green
    }
    else
    {
        Write-Host "One or more parameter checks are incorrect, exiting script." -ForegroundColor Red

        exit -1
    }

    Write-Host "Finished checking parameters at" (Get-Date).DateTime
    Write-Host ""
}


function PingLoopbackIpv6Address([System.Net.IPAddress]$loopBackIpv6Address)
{
    Write-Host "`nPing loopback IPv6 address on Windows.`n"
    CheckOsForWindows

    $loopBackIpv6Address = GetLoopBackIpv6Address $loopBackIpv6Address
    CheckParameters $loopBackIpv6Address

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started pinging loopback IPv6 address at" $startDateTime

        Test-Connection $loopBackIpv6Address
        
        Write-Host "Successfully pinged loopback IPv6 address." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished pinging loopback IPv6 address at" $finishedDateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch
    {
        Write-Host "Failed to ping loopback IPv6 address." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

PingLoopbackIpv6Address $loopBackIpv6Address
