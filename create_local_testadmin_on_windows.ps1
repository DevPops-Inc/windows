# create local testadmin on Windows

# prompt user input 
Write-Host "`nCreate local TestAdmin on Windows."
Pause

# declare testAdmin, testAdminPassword, testAdminDescription variables
$testAdmin = "TestAdmin"
$testAdminPassword = Read-Host -Prompt "`nPlease create password for TestAdmin (Example: Password123)`n"
$testAdminDescription = "TestAdmin"

# define CreatTestAdmin function 
function CreateTestAdmin()
{
    # create testAdmin and set password
    New-LocalUser "$testAdmin" -Password $testAdminPassword -FullName "$testAdmin" -Description "$testAdminDescription"

    # add testAdmin as local administrator
    Add-LocalGroupMember -Group "Administrators" -Member "$testAdmin"

    # set testAdmin password  to never expire
    Set-LocalUser -Name "$testAdmin" -PasswordNeverExpires 1

    # check if testAdmin has been added
    Get-LocalUser
}

# call CreateTestAdmin function
CreateTestAdmin
