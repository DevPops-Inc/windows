# delete local test user on Windows 

# run this script with: .\DeleteLocalTestUserOnWindows.ps1 -testUser < test user >

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $testUser = ""
)

function GetTestUser([string]$testUser)
{
    if (($testUser -eq $Null) -or ($testUser -eq ""))
    {
        $testUser = Read-Host -Prompt "`nPlease input test username (Example: testuser)"
        return $testUser
    }
    else 
    {
        return $testUser
    }
}

function DeleteTestUser([string]$testUser)
{
    Write-Host "`nDelete local test user on Windows`n"

    $testUser = GetTestUser $testUser

    try
    {
        # delete testUser
        Remove-LocalUser -Name "$testUser"

        Write-Host ("`nTest user {0} successfully deleted.`n" -F $testUser) -ForegroundColor Green

        Write-Host "The users on this computer are: `n"
        Get-LocalUser
    }
    catch
    {
        Write-Host ("`nTest user {0} failed to delete.`n" -F $testUser) -ForegroundColor Red

        Write-Host "The users on this computer are: `n"
        Get-LocalUser
    }
}

DeleteTestUser $testUser
