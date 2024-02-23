# create local testadmin on Windows

# run this script with: .\CreateLocalTestAdminOnWin.ps1 -testAdminPassword < test admin password >

[CmdletBinding()]
param(
    [string]       [Parameter(Mandatory = $False)] $testAdmin            = "TestAdmin", # you can set test admin username here
    [securestring] [Parameter(Mandatory = $False)] $testAdminPassword    = $Null, # you can set test admin password here
    [string]       [Parameter(Mandatory = $False)] $testAdminDescription = "TestAdmin" # you can set test admin description here
)

function CheckOsForWindows()
{
    Write-Host "Start checking operating system at" (Get-Date.DateTime)
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "Operating System:" $hostOs
        throw "Sorry but this script only works on Windows." 
    }
}

function GetTestAdmin([string]$testAdmin)
{
    if (($testAdmin -eq $Null) -or ($testAdmin -eq ""))
    {
        $testAdmin = Read-Host -Prompt "Please type test admin username and press `"Enter`" key (Example: TestAdmin)"

        Write-Host ""
        return $testAdmin
    }
    else 
    {
        return $testAdmin
    }
}

function GetTestAdminPassword([securestring]$testAdminPassword)
{
    if (($testAdminPassword -eq $Null) -or ($testAdminPassword -eq ""))
    {
        $testAdminPassword = Read-Host -Prompt "Please create password for TestAdmin and press `"Enter`" key (Example: Password123)" -AsSecureString
        
        Write-Host ""
        return $testAdminPassword
    }
    else
    {
        return $testAdminPassword
    }
}

function CheckParameters([string]      $testAdmin, 
                         [securestring]$testAdminPassword, 
                         [string]      $testAdminDescription)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-----------------------------------------------------"
    Write-Host ("testAdmin           : {0}" -F $testAdmin)
    Write-Host ("testAdminPassword   : {0}" -F "***")
    Write-Host ("testAdminDescription: {0}" -F $testAdminDescription)
    Write-Host "-----------------------------------------------------"

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

    if ($valid -eq $True)
    {
        Write-Host "All parameter check(s) passed." -ForegroundColor Green

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        throw "One or more paramaters are incorrect."
    }
}

function CreateTestAdmin([string]      $testAdmin, 
                         [securestring]$testAdminPassword, 
                         [string]      $testAdminDescription)
{
    Write-Host "`nCreate local TestAdmin on Windows.`n"
    CheckOsForWindows

    $testAdminPassword = GetTestAdminPassword $testAdminPassword
    CheckParameters $testAdmin $testAdminPassword $testAdminDescription

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started creating testAdmin account at: " $startDateTime.DateTime.DateTime

        New-LocalUser "$testAdmin" -Password $testAdminPassword -FullName "$testAdmin" -Description "$testAdminDescription"

        Add-LocalGroupMember -Group "Administrators" -Member "$testAdmin"
        Set-LocalUser -Name "$testAdmin" -PasswordNeverExpires 1
        Write-Host ("Successfully created {0} account." -F $testAdmin) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished creating testAdmin account at: " $finishedDateTime.DateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours, {1} minutes, {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""

        Write-Host "The users on this computer are: "
        Get-LocalUser
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
