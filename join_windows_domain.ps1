#!/bin/powershell

# join Windows domain

# declare variables
$DomainName = # Example:'domain.com'
$ADAdmin = # Example: 'DomainAdmin'

# join computer to domain
Add-Computer –DomainName $DomainName -Credential $ADAdmin -Restart –Force
