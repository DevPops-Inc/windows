# create remote mailbox in Exchange

# prompt user response
Write-Host "`nCreate remote mailbox in Exchange."
Pause

# declare email, password, firstName, and lastName variables
$email = Read-Host -Prompt "`nWhat is new email you wish to create? (Example: dev@vicphan.dev)"
$password = Read-Host -Prompt "`nWhat is the password for the email account? (Example: Password123)"
$firstName = Read-Host -Prompt "What is the first name for the account? (Example: Software)"
$lastName = Read-Host -Prompt "`nWhat is the last name for the account? (Example: Developer)"

# create remote mailbox 
New-Mailbox -UserPrincipalName $email  -Name $firstName$lastName -OrganizationalUnit Users -Password $password -FirstName $firstName -LastName $lastName -DisplayName "$firstName $lastName" -ResetPasswordOnNextLogon $false
