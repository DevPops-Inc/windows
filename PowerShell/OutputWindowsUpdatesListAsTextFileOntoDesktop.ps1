# output Windows updates list onto desktop

[CmdletBinding()]
param (
    [string] [Parameter(Mandatory = $False)] $filePath   = "C:\Users\$env:USERNAME\Desktop\", 
    [string] [Parameter(Mandatory = $False)] $winUpdates = "windowsupdates.txt"
)

function CheckOsForWindows()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System: " (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "Your operating system is:" $hostOs
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""

        break
    }
}

function getFilePath([string]$filePath)
{
    if (($filePath -eq $Null) -or ($filePath -eq ""))
    {
        $filePath = Read-Host -Prompt "Please type the path you wish to save the Windows update file to and press the `"Enter`" key (Example: C:\Users\$env:USERNAME\Desktop\)"

        Write-Host ""
        return $filePath
    }
    else
    {
        return $filePath
    }
}

function getWinUpdates([string]$winUpdates)
{
    if (($winUpdates -eq $Null) -or ($winUpdates -eq ""))
    {
        $winUpdates = Read-Host -Prompt "Please type the Windows updates filename and press the `"Enter`" key (Example: windowsupdates.txt)"

        Write-Host ""
        return $winUpdates
    }
    else 
    {
        return $winUpdates
    }
}

function checkParameters([string]$filePath, [string]$winUpdates)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $true

    Write-Host "Parameter(s):"
    Write-Host "-------------"
    Write-Host ("filePath: {0}" -F $filePath)
    Write-Host 
}

function OutputWindowsUpdateListOntoDesktop()
{
    Write-Host "`nOutput list of Windows updates as text file onto desktop.`n"
    CheckOsForWindows

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started outputing Windows update list at" $startDateTime.DateTime

        $winUpdatesFile = Join-Path -Path $filePath -ChildPath "windowsupdates.txt"

        Get-Hotfix | Out-File  $winUpdatesFile
        Get-ChildItem $winUpdatesFile
        notepad $winUpdatesFile
        Write-Host "Successfully output windows update list onto desktop." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished outputting Windows update list at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2}" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch 
    {
        Write-Host "Failed to output Windows update list onto desktop." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
        Get-ChildItem $winUpdatesFile
    }
}

OutputWindowsUpdateListOntoDesktop
