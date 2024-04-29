# ping loopback IPv4 address on Windows

# you can run this script with: ./PingLoopBackIpv4AddressOnWin.ps1 -loopbackIpv4Address < IPv4 loopback address > 

[CmdletBinding()]
param(
    [System.Net.IPAddress] [Parameter(Mandatory = $False)] $loopbackIpv4Address = "127.0.0.1"
)

function CheckOs()
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
        Write-Host "Operating System:" $hostOs -ForegroundColor Green
        throw "Sorry but this script only runs on Windows." 
    }
}

function GetLoopbackIpv4Address([System.Net.IPAddress]$loopbackIpv4Address)
{
    if (($loopbackIpv4Address -eq $Null) -or ($loopbackIpv4Address -eq ""))
    {
        $loopbackIpv4Address = Read-Host -Prompt "Please type the IPv4 address you would like to use for loopback and press the `"Enter`" key (Example: 127.0.0.1)"

        Write-Host ""
        return $loopbackIpv4Address
    }
    else
    {
        return $loopbackIpv4Address
    }
}

function CheckParameters([System.Net.IPAddress]$loopbackIpv4Address)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $true

    Write-Host "Parameter(s):"
    Write-Host "---------------------------------------------------"
    Write-Host ("loopbackIpv4Address: {0}" -F $loopbackIpv4Address)
    Write-Host "---------------------------------------------------"

    if (($loopbackIpv4Address -eq $Null) -or ($loopbackIpv4Address -eq ""))
    {
        Write-Host "loopbackIpv4Address is not set." -ForegroundColor Red
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
        throw "One or more parameter checks are incorrect."
    }
}

function PingLoopbackIpv4Address([System.Net.IPAddress]$loopbackIpv4Address)
{
    Write-Host "`nPing loopback IPv4 address.`n"
    CheckOs

    $loopbackIpv4Address = GetLoopbackIpv4Address $loopbackIpv4Address
    CheckParameters $loopbackIpv4Address

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started pinging loopback IPv4 address at" $startDateTime.DateTime

        Test-Connection $loopbackIpv4Address
        Write-Host "Successfully pinged loopback IPv4 address." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished pinging loopback IPv4 address at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host "Failed to ping looopback IPv4 address." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

PingLoopbackIpv4Address $loopbackIpv4Address
