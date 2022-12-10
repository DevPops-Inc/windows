# delete all dshortcuts except one on Windows

# run this script as admin: Start-Process Powershell -Verb runAs

# you can run this script with: .\DeleteAllShortcutsExceptOneOnWindows.ps1 -excludePath < exclude path > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $deletePath  = "C:\Users\Public\Desktop\*.lnk", 
    [string] [Parameter(Mandatory = $False)] $excludePath = "" # you can set the .lnk file you wish to exclude from deletion here
)

function CheckOsForWindows() 
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
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
        Write-Host "Sorry but this script only runs on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""

        break
    }
}

function GetDeletePath([string]$deletePath)
{
    if (($deletePath -eq $Null) -or ($deletePath -eq ""))
    {
        $deletePath = Read-Host -Prompt "Please type the delete path and press `"Enter`" key (Example: C:\Users\Public\Desktop\*.lnk)"

        Write-Host ""
        return $deletePath
    }
    else 
    {
        return $deletePath
    }
}

function GetExcludePath([string]$excludePath)
{
    if (($excludePath -eq $Null) -or ($excludePath -eq ""))
    {
        $excludePath = Read-Host -Prompt "Please type the exclude path and press `"Enter`" key (Example: Firefox.lnk)"

        Write-Host ""
        return $excludePath
    }
    else
    {
        return $excludePath
    }
}

function CheckParameters([string]$deletePath, [string]$excludePath)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-----------------------------------"
    Write-Host ("deletePath : {0}" -F $deletePath)
    Write-Host ("excludePath: {0}" -F $excludePath)
    Write-Host "-----------------------------------"

    if (($deletePath -eq $Null) -or ($deletePath -eq ""))
    {
        Write-Host "deletePath is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($excludePath -eq $Null) -or ($excludePath -eq ""))
    {
        Write-Host "excludePath is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter check(s) passsed." -ForegroundColor Green

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "One or more parameters are incorrect." -ForegroundColor Red
        
        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
        
        break
    }
}

function DeleteShortcuts([string]$deletePath, [string]$excludePath)
{
    Write-Host "`nDelete all shortcuts except one on Windows.`n"
    CheckOsForWindows

    $deletePath  = GetDeletePath $deletePath
    $excludePath = GetExcludePath $excludePath
    CheckParameters $deletePath $excludePath

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started deleting shortcuts at" $startDateTime.DateTime

        Remove-Item $deletePath -Exclude $excludePath -Force
        Write-Host "Successfully deleted shortcuts." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished deleting shortcuts at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host "Failed to delete shortcuts." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

DeleteShortcuts $deletePath $excludePath
