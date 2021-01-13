#!/bin/powershell

# install OpenSSH on Windows

# PowerShell has to be version 6 and up
# PowerShell must be ran in Administrator mode: 
# Start-Process Powershell -Verb runAs

# get OpenSSH status
Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'

# install OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# install OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# set OpenSSH services to automatically start up
Set-Service ssh-agent -StartupType Automatic
Set-Service sshd -StartupType Automatic

# start up OpenSSH services
Start-Service ssh-agent
Start-Service sshd

# get OpenSSH services statuses
Get-Service "*ssh*"

# get IP address
ipconfig

# get hostname and user accounts
net user
