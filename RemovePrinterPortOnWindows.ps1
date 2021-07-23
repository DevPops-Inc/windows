# remove printer port on Windows

# you can run this script with: .\RemovePrinterPortOnWindows.ps1 -ipAddress < IP address > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $ipAddress = ""
)

function GetIpAddress([string]$ipAddress)
{
    if (($ipAddress -eq $Null) -or ($ipAddress -eq ""))
    {
        $ipAddress = Read-Host -Prompt "Please type the IP address of the printer port you wish to remove and press `"Enter`" key (Example: 127:20:1)"

        return $ipAddress
    }
    else
    {
        return $ipAddress
    }
}

function CheckOsForWindows()
{
    Write-Host "`nChecking operating system..."
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green
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

function RemovePrinterPort([string]$ipAddress)
{
    Write-Host "`nRemove printer port on Windows.`n"
    CheckOsForWindows

    $ipAddress = GetIpAddress $ipAddress
    
    try 
    {
        Remove-PrinterPort -Name $ipAddress -PrinterHostAddress $ipAddress
        
        Write-Host ("Successfully removed printer port with this IP address: {0}" -F $ipAddress) -ForegroundColor Green
    }
    catch 
    {
        Write-Host ("Failed to remove printer port with this IP address: {0}" -F $ipAddress) -ForegroundColor Red
    }
}

RemovePrinterPort $ipAddress
