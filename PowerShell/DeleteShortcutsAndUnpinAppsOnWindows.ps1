# delete shortcuts and unpin apps on Windows

# run this script as admin:  Start-Process PowerShell -Verb RunAs

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $deletePath = "C:\Users\Public\Desktop\*.lnk"
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

        Write-Host "Finished checking operating system at" (Get-Date).Date
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

function CheckParameters([string]$deletePath)
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

function DeleteShortcuts([string]$deletePath)
{
    Write-Host "Started deleting shortcuts at" (Get-Date).DateTime

    Remove-Item $deletePath -Force
    Write-Host "Successfully deleted shortcuts." -ForegroundColor Green

    Write-Host "Finished deleting shortcuts at" (Get-Date).DateTime
    Write-Host ""
}

function UnpinApp([string]$appname) 
{
    ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() |
        Where-Object {$_.Name -eq $appname}).Verbs() | 
        Where-Object {$_.Name.replace('&','') -match 'Unpin from taskbar'} | 
        ForEach-Object {$_.DoIt()}
}

function UnpinAppsFromTaskbar() 
{
    Write-Host "Started unpinning apps at" (Get-Date).DateTime

    $apps = "Microsoft Edge", "Microsoft Store", "Mail", "File Explorer" # list the apps on the taskbar here
    
    foreach ($app in $apps)
    {
        Write-Host "Unpinning:" $app
        UnpinApp($app)
    }

    Write-Host "Successfully unpinned apps." -ForegroundColor Green

    Write-Host "Finished unpinning apps at" (Get-Date).DateTime
    Write-Host ""
}


function DeleteShortcutsAndUnpinApps([string]$deletePath) 
{
    Write-Host "`nDelete shortcuts except Firefox and unpin apps on Windows.`n"
    CheckOsForWindows

    $deletePath = GetDeletePath $deletePath
    CheckParameters $deletePath 

    try
    {
        $startDateTime = (Get-Date)

        Write-Host "Started deleting shortcuts and unpinning appsat" $startDateTime.DateTime

        DeleteShortcuts $deletePath 
        UnpinAppsFromTaskbar
        
        Write-Host "Successfully deleted shortcuts and unpinned apps." -ForegroundColor Green

        $finishedDateTime = (Get-Date)

        Write-Host "Finished deleting shortcuts and unpinning apps at" $finishedDateTime.DateTime

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

DeleteShortcutsAndUnpinApps $deletePath 
