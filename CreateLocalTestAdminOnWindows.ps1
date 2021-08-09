# create local testadmin on Windows

# run this script with: .\CreateLocalTestAdminOnWindows.ps1 -testAdminPassword < test admin password >

[CmdletBinding()]
param(
      [string]       [Parameter(Mandatory = $False)] $testAdmin = "TestAdmin"
    , [securestring] [Parameter(Mandatory = $False)] $testAdminPassword = $Null
    , [string]        [Parameter(Mandatory = $False)] $testAdminDescription = "TestAdmin"
)

function CheckOsForWindows()
{
    Write-Host "`nChecking operating system..."
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green
    }
    else 
    {
        Write-Host "Operating System:" $hostOs
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system.`n"
        break
    }
    Write-Host "Finished checking operating system.`n"
}

function GetTestAdminPassword()
{
    if (($testAdminPassword -eq $Null) -or ($testAdminPassword -eq ""))
    {
        $testAdminPassword = Read-Host -Prompt "Please create password for TestAdmin and press `"Enter`" key (Example: Password123)" -AsSecureString
        
        return $testAdminPassword
    }
    else
    {
        return $testAdminPassword
    }
}

function CheckParameters([string]$testAdmin, [securestring]$testAdminPassword, [string]$testAdminDescription)
{
    Write-Host "`nStarted checking parameters..."
    $valid = $True

    Write-Host "`nParameters:"
    Write-Host "----------------------------------------"
    Write-Host ("testAdmin           : {0}" -F $testAdmin)
    Write-Host ("testAdminPassword   : {0}" -F "***")
    Write-Host ("testAdminDescription: {0}" -F $testAdminDescription)
    Write-Host "----------------------------------------"

    if (($testAdmin -eq $Null) -or ($testAdmin -eq ""))
    {
        Write-Host "testAdmin is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($testAdminPassword -eq $Null) -or ($testAdminPassword -eq ""))
    {
        Write-Host "testAdminPassword is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($testAdminDescription -eq $Null) -or ($testAdminDescription -eq ""))
    {
        Write-Host "testAdminDescription is not set." -ForegroundColor Red
        $valid = $True
    }

    Write-Host "Finished checking parameters."

    if ($valid = $True)
    {
        Write-Host "All parameters checks passed." -ForegroundColor Green
    }
    else 
    {
        Write-Host "One or more paramateres are incorrect, exiting script." -ForegroundColor Red
        exit $result
    }
    
    Write-Host ""
}

function CreateTestAdmin([string]$testAdmin, [securestring]$testAdminPassword, [string]$testAdminDescription)
{
    Write-Host "`nCreate local TestAdmin on Windows.`n"
    CheckOsForWindows

    $testAdminPassword = GetTestAdminPassword $testAdminPassword
    CheckParameters $testAdmin $testAdminPassword $testAdminDescription

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started creating testAdmin account at: " $startDateTime

        New-LocalUser "$testAdmin" -Password $testAdminPassword -FullName "$testAdmin" -Description "$testAdminDescription"

        Add-LocalGroupMember -Group "Administrators" -Member "$testAdmin"

        Set-LocalUser -Name "$testAdmin" -PasswordNeverExpires 1

        Write-Host ("Successfully created {0} account." -F $testAdmin) -ForegroundColor Green

        Write-Host "The users on this computer are: "
        Get-LocalUser

        $finishedDateTime = (Get-Date)
        Write-Host "Finished creating testAdmin account at: " $finishedDateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours, {1} minutes, {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host ("Failed to create {0} account." -F $testAdmin) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        
        Write-Host "The users on this computer are: "
        Get-LocalUser
    }
}

CreateTestAdmin $testAdmin $testAdminPassword $testAdminDescription
