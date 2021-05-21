# create new active directory user 

# prompt user response
Write-Host "`nCreate new Active Directory user."
Pause

# declare newAdUser and newPassword variables
$newAdUser = Read-Host -Prompt "`nWhat is the username of the new Active Directory user? (Example: software.developer)"
$newPassword = Read-Host -Prompt "`nPlease type the password for the new user (Example: Password123)"


# define CreateNewAdUser function
function CreateNewAdUser()
{
    # create new AD user
    New-ADUser $newAdUser 

    # set the password
    Set-ADAccountPassword -Identity $newAdUser -NewPassword (ConvertTo-SecureString -AsPlainText $newPassword -Force)
}

# call CreateNewAdUser function 
CreateNewAdUser
