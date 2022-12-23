# remove printer port on Windows

# you can run this script with: .\RemovePrinterPortOnWindows.ps1 -ipAddress < IP address > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $ipAddress = "" # you can set the IP address here
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
        Write-Host "Your operating system is:" $hostOs
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""

        break
    }
}

function GetIpAddress([string]$ipAddress)
{
    if (($ipAddress -eq $Null) -or ($ipAddress -eq ""))
    {
        $ipAddress = Read-Host -Prompt "Please type the IP address of the printer port you wish to remove and press the `"Enter`" key (Example: 127.20.1)"

        Write-Host ""
        return $ipAddress
    }
    else
    {
        return $ipAddress
    }
}

function CheckParameters([string]$ipAddress)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-------------------------------"
    Write-Host ("ipAddress: {0}" -F $ipAddress)
    Write-Host "-------------------------------"

    if (($ipAddress -eq $Null) -or ($ipAddress -eq ""))
    {
        Write-Host "ipAddress is not set." -ForegroundColor red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter check(s) passed." -ForegroundColor Green
    }
    else 
    {
        Write-Host "One or more parameter checks are incorrect, exiting script." -ForegroundColor Red

        exit -1
    }

    Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
    Write-Host ""
}

function RemovePrinterPort([string]$ipAddress)
{
    Write-Host "`nRemove printer port on Windows.`n"
    CheckOsForWindows

    $ipAddress = GetIpAddress $ipAddress
    CheckParameters $ipAddress

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started removing printer port at" $startDateTime.DateTime
        
        Remove-PrinterPort -Name $ipAddress -PrinterHostAddress $ipAddress
        
        Write-Host ("Successfully removed printer port with this IP address: {0}" -F $ipAddress) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished removing printer port at" $finishedDateTime.DateTime
    }
    catch 
    {
        Write-Host ("Failed to remove printer port with this IP address: {0}" -F $ipAddress) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

RemovePrinterPort $ipAddress
