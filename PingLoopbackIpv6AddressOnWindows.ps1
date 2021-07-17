# ping loopback IPv6 address on Windows 

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

function PingLoopbackIpv6Address()
{
    Write-Host "`nPing loopback IPv6 address on Windows.`n"
    CheckOsForWindows

    try
    {
        ping ::1
        
        Write-Host "Successfully pinged loopback IPv6 address." -ForegroundColor Green
    }
    catch
    {
        Write-Host "Failed to ping looopback IPv6 address." -ForegroundColor Red
    }
}

PingLoopbackIpv6Address
