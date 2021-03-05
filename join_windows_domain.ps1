#!/bin/powershell

# join Windows domain

# declare variables
$DomainName = Read-Host -Prompt "What domain do you want to join? (Example: domain.com"
$ADAdmin = Read-Host -Prompt "Example: DomainAdmin"

# join computer to domain
Add-Computer –DomainName $DomainName -Credential $ADAdmin -Restart –Force
