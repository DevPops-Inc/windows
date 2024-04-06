# check Chrome on Windows

[CmdletBinding()]
param (
    [string] [Parameter(Mandatory = $False)] $checkProgram = "Google Chrome"
)

function CheckOsForWin()
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
        throw "Sorry but this script only runs on Windows."
    }
}

function GetCheckProgram([string]$checkProgram)
{
    if (($checkProgram -eq "") -or ($checkProgram -eq $Null))
    {
        $checkProgram = Read-Host -Prompt "Please type the program you wish to check and press the `Enter` key (Example: Google Chrome)"

        Write-Host ""
        return $checkProgram
    }
    else
    {
        return $checkProgram
    }
}

function GetWinPrograms()
{
    Write-Host "Started getting Windows programs at" (Get-Date).DateTime

    $winProgramsList = New-Object Collections.Generic.List[string]

    $winPrograms = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | ForEach-Object {$_.DisplayName} 

    $winPrograms2 = Get-WmiObject -Class Win32_Product | ForEach-Object {$_.Name}

    Foreach ($program in $winPrograms)
    {
        if ($Null -ne $program)
        {
            $winProgramsList.Add($program)
        }
         
    }

    Foreach ($program in $winPrograms2)
    {
        if (($program -notin $winProgramsList) -and ($Null -ne $program))
        {
            $winProgramsList.Add($program) 
        }
    }

    Write-Host ($winProgramsList -join "`n") -ForegroundColor Blue
    Write-Host "Successfully got Windows programs" -ForegroundColor Green

    Write-Host "Finished getting Windows programs at" (Get-Date).DateTime
    Write-Host ""

    return $winProgramsList
}

function CheckParameters([string]$checkProgram)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $true

    Write-Host "Parameter(s):"
    Write-Host "-------------------------------------"
    Write-Host ("checkProgram: {0}" -F $checkProgram)
    Write-Host "-------------------------------------"

    if (($checkProgram -eq "") -or ($checkProgram -eq $Null))
    {
        Write-Host "checkProgram is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter check(s) passed." -ForegroundColor Green

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        throw "One or more parameters are incorrect." 
    }
}

function CheckChrome()
{
    Write-Host "`nCheck Chrome on Windows.`n"
    CheckOsForWin

    $checkProgram    = GetCheckProgram $checkProgram
    $winProgramsList = GetWinPrograms
    CheckParameters $checkProgram 

    try
    {
        $startDateTime = (Get-Date)
        Write-Host ("Started checking {0} at {1}" -F $checkProgram, $startDateTime.DateTime)

        if ($winProgramsList -contains $checkProgram)
        {
            Write-Host ("{0} is installed." -F $checkProgram) -ForegroundColor Green
        }
        else 
        {
            Write-Host ("{0} is not installed." -F $checkProgram) -ForegroundColor Red
        }

        Write-Host ("Successfully checked {0}." -F $checkProgram) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        
        Write-Host ("Finished checking {0} at {1}" -F $checkProgram, $finishedDateTime.DateTime)

        $duration = New-TimeSpan $startDateTime $finishedDateTime
        
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host ("Failed to check {0}" -F $checkProgram) -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

CheckChrome
