# join Windows domain

# prompt user input
Write-Host "`nJoin Windows domain."
Pause

# declare variables
$DomainName = Read-Host -Prompt "`nWhat domain do you want to join? (Example: domain.com)`n"
$DomainAdmin = Read-Host -Prompt "`nWhat is your domain admin account? Example: DomainAdmin)`n"

# join computer to domain
Add-Computer –DomainName $DomainName -Credential $DomainAdmin -Restart –Force
