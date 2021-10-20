# rename computer on Windows 

# you can run this script with: .\RenameComputerOnWindows.ps1 -newName < new computer name > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $newName = ""
)

function CheckOsForWindows()
{
    Write-Host "`nStarted checking operating system at" (Get-Date).DateTime
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
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system.`n"
        break
    }
}

function GetNewName([string]$newName)
{
    if (($newName -eq $Null) -or ($newName -eq ""))
    {
        $newName = Read-Host -Prompt "Please type what you wish the new compter to be and press `"Enter`" key (Example: DEV-PC)"

        Write-Host ""
        return $newName
    }
    else 
    {
        return $newName
    }
}

function CheckParameters([string]$newName)
{
    Write-Host "Started checking parameters at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameters:"
    Write-Host "---------------------------"
    Write-Host ("newName: {0}" -F $newName)
    Write-Host "---------------------------"

    if (($newName -eq $Null) -or ($newName -eq ""))
    {
        Write-Host "newName is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter checks passed." -ForegroundColor Green
    }
    else 
    {
        Write-Host "One or more parameter checks are incorrect, exiting script." -ForegroundColor Red

        exit -1
    }

    Write-Host "Finished checking parameters at" (Get-Date).DateTime
    Write-Host ""
}

function RenameComputer([string]$newName)
{
    Write-Host "`nRename computer on Windows.`n"
    CheckOsForWindows

    $newName = GetNewName $newName
    CheckParameters $newName

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started renaming computer at" $startDateTime

        Rename-Computer -NewName "$newName" -DomainCredential Domain01\Admin01 -Restart

        Write-Host ("Successfully renamed computer to {0}." -F $newName) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished renaming computer at" $finishedDateTime
    }
    catch
    {
        Write-Host ("Failed to rename the computer to {0}." -F $newName) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
    finally
    {
        $hostName = $Env:COMPUTERNAME
        Write-Host "The computer name is:" $hostName
    }
}

RenameComputer $newName
