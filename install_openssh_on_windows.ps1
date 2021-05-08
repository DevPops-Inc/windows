# install OpenSSH on Windows

# prompt user input
Write-Host "`nInstall OpenSSH on Windows.`nPowerShell has to be version 6 and up.`nPowerShell must be ran in Administrator mode: Start-Process Powershell -Verb runAs`n"
Pause

# install OpenSSH Client and OpenSSH Server
function InstallOpenSshClientAndServer()
{
    Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
    Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
}

# set OpenSSH services to automatically start up
function AutoStartOpehSshServices()
{
    Set-Service ssh-agent -StartupType Automatic
    Set-Service sshd -StartupType Automatic
}

# start up OpenSSH services
function StartOpenSshServices()
{
    Start-Service ssh-agent
    Start-Service sshd
}

function InstallOpenSshOnWindows()
{
    # get OpenSSH status
    Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'
    
    # call previous functions 
    InstallOpenSshClientAndServer
    AutoStartOpehSshServices
    StartOpenSshServices

    # get OpenSSH services statuses
    Get-Service "*ssh*"

    # get IP address
    ipconfig

    # get hostname and user accounts
    net user
}

# call main function 
InstallOpenSshOnWindows
