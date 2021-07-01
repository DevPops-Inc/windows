# install OpenSSH on Windows

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

function InstallOpenSshClientAndServer()
{
    Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
    Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
}

function AutoStartOpehSshServices()
{
    Set-Service ssh-agent -StartupType Automatic
    Set-Service sshd -StartupType Automatic
}

function StartOpenSshServices()
{
    Start-Service ssh-agent
    Start-Service sshd
}

# define main function 
function InstallOpenSsh()
{
    Write-Host "`nInstall OpenSSH on Windows.`n`nPowerShell has to be version 6 and up.`nPowerShell must be ran in Administrator mode: Start-Process Powershell -Verb runAs`n"

    CheckOsForWindows

    try 
    {
        Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'
        
        InstallOpenSshClientAndServer
        AutoStartOpehSshServices
        StartOpenSshServices

        Write-Host "Successfully installed OpenSSH." -ForegroundColor Green    
        Get-Service "*ssh*"
        ipconfig
        Get-User
    }
    catch 
    {
        Write-Host "Failed to install OpenSSH.`n" -ForegroundColor Red
    }

}

InstallOpenSsh
