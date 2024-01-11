# looking forward to working together 

# you can run this script with: .\LookingForwardToWorkingTogether.ps1 -buddy < your buddy > on Windows or pwsh LookingForwardToWorkingTogether.ps -buddy < your buddy > on Mac or Linux

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $buddy = "" # you can set your buddy's name here 
)

function CheckOs()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green
    }
    else
    {
        Write-Host "Operating System:" $hostOs -ForegroundColor Green
    }

    Write-Host "Finished checking operating system at" (Get-Date).DateTime
    Write-Host ""
}

function GetBuddy([string]$buddy)
{
    if (($buddy -eq $Null) -or ($buddy -eq ""))
    {
        Read-Host -Prompt "Please type your buddy's name and press `"Enter`" key on Windows or `"return`" key on Mac or Linux (Example: James)" 

        return $buddy
    }
    else
    {
        return $buddy
    }
}

function CheckParameters([string]$buddy)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "`nParameter(s):"
    Write-Host "-----------------------"
    Write-Host ("buddy: {0}" -F $buddy)
    Write-Host "-----------------------"

    if (($buddy -eq $Null) -or ($buddy -eq ""))
    {
        Write-Host "buddy is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter check(s) passed." -ForegroundColor Green
    }
    else 
    {
        Write-Host "One or more parameter checks are incorret, exiting script." -ForegroundColor Red

        exit -1
    }

    Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
    Write-Host ""
}

function LookingForward()
{
    Write-Host "`nLooking Forward to Working Together.`n"
    CheckOs

    $buddy = GetBuddy $buddy
    CheckParameters $buddy

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started looking forward to you at" $startDateTime.DateTime
        
        $colors = 'White', 'DarkRed', 'Red', 'Yellow', 'DarkYellow', 'Green', 'DarkGreen', 'DarkBlue', 'Blue', 'DarkCyan', 'Cyan', 'Magenta', 'DarkMagenta', 'Black'

        foreach ($color in $colors)
        {
            Write-Host ("Looking forward to working together, {0}!" -F $buddy) -Foregroundcolor $color 

            Start-Sleep -s 1 
        }

        $finishedDateTime = (Get-Date)
        Write-Host "Finished looking forward to working together at" $finishedDateTime.DateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch
    {
        Write-Host("Failed to look forward to working with you, {0}." -F $buddy)-ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

LookingForward
