# set vi for Notepad on Windows

# you have to update the $Profile for this change to persist

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $newAlias = "vi", 
    [string] [Parameter(Mandatory = $False)] $app = "notebook"
)

function GetNewAlias([string]$newAlias)
{
    if (($newAlias -eq $Null) -or ($newAlias -eq ""))
    {
        Read-Host -Prompt "Please type the new alias and press `"Enter`" key (Example: vi)"

        Write-Host ""
        return $newAlias
    }
    else 
    {
        return $newAlias
    }
}

function GetApp([string]$app)
{
    if (($app -eq $Null) -or ($app -eq ""))
    {
        Read-Host -Prompt "Please type the application you wish to create an alias for and press `"Enter`" key (Example: notebook)"

        Write-Host ""
        return $app
    }
    else 
    {
        return $app
    }
}

function CheckParameters([string]$newAlias, [string]$app)
{
    Write-Host "Started checking parameters at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameters:"
    Write-Host "---------------------------------"
    Write-Host ("newAlias    : {0}" -F $newAlias)
    Write-Host ("app        : {0}" -F $app)
    Write-Host "----------------------------------"
    
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

    if ($valid -eq $True)
    {
        Write-Host "All parameters checks passed." -ForegroundColor Green
    }
    else
    {
        Write-Host "One or more parameters are incorrect, exiting script." -ForegroundColor Red

        exit -1
    }

    Write-Host "Finished checking parameters at" (Get-Date).DateTime
    Write-Host ""
}

function CheckOsForWindows()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host "'"
    }
    else 
    {
        Write-Host "Operating System:" $hostOs
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        break
    }
}

function SetViForNotepad([string]$newAlias, [string]$app)
{
    Write-Host "`nSet vi for Notepad on Windows`n"
    CheckOsForWindows

    $newAlias = GetNewAlias $newAlias
    $app = GetApp $app
    CheckParameters $newAlias $app

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started setting vi for Notepad at" $startDateTime

        New-Alias vi notepad

        Write-Host "Successfully set vi for Notepad." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished setting vi for Notepad at" $finishedDateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host "Failed to set vi for Notepad." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

SetViForNotepad $newAlias $app