# install OpenSSH on Windows

# PowerShell has to be version 6 and up.
# run this script as admin: Start-Process PowerShell -Verb RunAs

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

function InstallOpenSshClient()
{
    Write-Host "Started installing OpenSSH client at" (Get-Date).DateTime
    
    Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
    
    Write-Host "Finished installing OpenSSH client at" (Get-Date).DateTime
    Write-Host ""
}

function InstallOpenSshServer()
{
    Write-Host "Started installing OpenSSH server at" (Get-Date).DateTime
    
    Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
    
    Write-host "Finished install OpenSSH server at" (Get-Date).DateTime
    Write-Host ""
}

function AutoStartOpehSshServices()
{
    Write-Host "Started setting OpenSSH services to autostart at" (Get-Date).DateTime

    Set-Service ssh-agent -StartupType Automatic
    Set-Service sshd -StartupType Automatic

    Write-Host "Finished setting OpenSSH servers to autostart at" (Get-Date).DateTime
    Write-Host ""
}

function StartOpenSshServices()
{
    Write-Host "Starting OpenSSH services at" (Get-Date).DateTime
    
    Start-Service ssh-agent
    Start-Service sshd

    Write-Host "Finished starting OpenSSH services at" (Get-Date).DateTime
    Write-Host ""
}

function InstallOpenSsh()
{
    Write-Host "`nInstall OpenSSH on Windows.`n"
    CheckOsForWin

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started installing OpenSSH at" $startDateTime.DateTime

        Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
        
        InstallOpenSshClient
        InstallOpenSshServer
        AutoStartOpehSshServices
        StartOpenSshServices

        Write-Host "Successfully installed OpenSSH." -ForegroundColor Green    
        
        Get-Service "*ssh*"
        ipconfig
        Get-User

        $finishedDateTime = (Get-Date)
        Write-Host "Finished installing OpenSSH at" $finishedDateTime.DateTime
        
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch 
    {
        Write-Host "Failed to install OpenSSH." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

InstallOpenSsh
