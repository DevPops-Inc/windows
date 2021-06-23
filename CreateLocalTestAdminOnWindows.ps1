# create local testadmin on Windows

# run this script with: .\CreateLocalTestAdminOnWindows.ps1 -testAdminPassword < test admin password >

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $testAdmin = "TestAdmin"
    , [string] [Parameter(Mandatory = $False)] $testAdminPassword = ""
    , [string] [Parameter(Mandatory = $False)] $testAdminDescription = "TestAdmin"
)

function GetTestAdminPassword()
{
    if (($testAdminPassword -eq $Null) -or ($testAdminPassword -eq ""))
    {
        $testAdminPassword = Read-Host -Prompt "`nPlease create password for TestAdmin (Example: Password123)`n"
        return $testAdminPassword
    }
    else
    {
        return $testAdminPassword
    }
}

function CreateTestAdmin([string]$testAdmin, [string]$testAdminPassword, [string]$testAdminDescription)
{
    Write-Host "`nCreate local TestAdmin on Windows."

    try 
    {
          # create testAdmin and set password
        New-LocalUser "$testAdmin" -Password $testAdminPassword -FullName "$testAdmin" -Description "$testAdminDescription"

        # add testAdmin as local administrator
        Add-LocalGroupMember -Group "Administrators" -Member "$testAdmin"

        # set testAdmin password  to never expire
        Set-LocalUser -Name "$testAdmin" -PasswordNeverExpires 1

        
        Write-Host ("`n{0} account has been created.`n" -F $testAdmin) -ForegroundColor Green

        # check if testAdmin has been added
        Write-Host "`nThe users on this computer are: `n"
        Get-LocalUser
    }
    catch 
    {
        Write-Host ("`nFailed to create {0} account.`n" -F $testAdmin) -ForegroundColor Red
        
        Write-Host "`nThe users on this computer are: `n"
        Get-LocalUser
    }
  
}

CreateTestAdmin $testAdmin $testAdminPassword $testAdminDescription
