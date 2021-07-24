# rename computer on Windows 

# you can run this script with: .\RenameComputerOnWindows.ps1 -newName < new computer name > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $newName = ""
)

function GetNewName([string]$newName)
{
    if (($newName -eq $Null) -or ($newName -eq ""))
    {
        $newName = Read-Host -Prompt "Please type what you wish the new compter to be and press `"Enter`" key (Example: DEV-PC)"

        return $newName
    }
    else 
    {
        return $newName
    }
}

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

function RenameComputer([string]$newName)
{
    Write-Host "`nRename computer on Windows.`n"
    CheckOsForWindows

    $newName = GetNewName $newName

    try 
    {
        Rename-Computer -NewName "$newName" -DomainCredential Domain01\Admin01 -Restart

        Write-Host ("Successfully renamed computer to {0}." -F $newName) -ForegroundColor Green
    }
    catch
    {
        Write-Host ("Failed to rename the computer to {0}." -F $newName) -ForegroundColor Red
    }
    finally
    {
        $hostName = $Env:COMPUTERNAME
        Write-Host "The computer name is:" $hostName
    }
}

RenameComputer $newName
