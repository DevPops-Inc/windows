# create new AD user and assign permissions

# declare newAdUser and newPassword variables
$newAdUser = Read-Host -Prompt "`nWhat is the username of the new Active Directory user? (Example: software.developer)"
$newPassword = Read-Host -Prompt "`nPlease type the password for the new user (Example: Password123)"
$groupName = Read-Host -Prompt "`nWhat group do you want to assign the user to? (example: developers)"

# define CreateNewAdUser function
function CreateNewAdUser()
{
    # create new AD user
    New-ADUser $newAdUser 

    # set the password
    Set-ADAccountPassword -Identity $newAdUser -NewPassword (ConvertTo-SecureString -AsPlainText $newPassword -Force)

    # assign permissions
    Add-ADGroupMember -Identity $groupName -Members $newADUser
}

# call CreateNewAdUser function 
CreateNewAdUser
