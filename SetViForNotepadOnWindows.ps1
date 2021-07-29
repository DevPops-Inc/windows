# set vi for Notepad in PowerShell

# you have to update the $Profile for this change to persist

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $newAlias = "vi"
    , [string] [Parameter(Mandatory = $False)] $app = "notebook"
)

function CheckParameters([string]$newAlias, [string]$app)
{
    Write-Host "`nStarted checking parameters..."
    $valid = $True

    Write-Host "`nParameters:"
    Write-Host "----------------------------------------"
    Write-Host ("newAlias    : {0}" -F $newAlias)
    Write-Host ("app        : {0}" -F $app)
    Write-Host "----------------------------------------`n"
    
    if (($newAlias -eq $Null) -or ($newAlias -eq ""))
    {
        Write-Host "newAlias is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($app -eq $Null) -or ($app -eq ""))
    {
        Write-Host "app is not set." -ForegroundColor Red
        $valid = $False
    }

    Write-Host "Finished checking parameters."

    if ($valid -eq $True)
    {
        Write-Host "All parameters checks passed." -ForegroundColor Green
    }
    else
    {
        Write-Host "One or more parameters are incorrect, exiting script." -ForegroundColor Red
        exit $result
    }
    Write-Host ""
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

function SetViForNotepad([string]$newAlias, [string]$app)
{
    Write-Host "`nSet vi for Notepad in PowerShell`n"
    CheckParameters $newAlias $app
    CheckOsForWindows

    try 
    {
        New-Alias vi notepad

        Write-Host "Successfully set vi for Notepad." -ForegroundColor Green
    }
    catch 
    {
        Write-Host "Failed to set vi for Notepad." -ForegroundColor Red
        Write-Host $_ -ForegroundColor
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

SetViForNotepad $newAlias $app
