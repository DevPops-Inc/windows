# export system info to text file

# you can run this script with: .\ExportSystemInfoAsTextFileOnWindows.ps1 -systemInfoFile < system info filename > -fileDestination < file destination >

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $systemInfoFile = "" # you can set system info file here
    , [string] [Parameter(Mandatory = $False)] $fileDestination = "" # you can set file path here
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
        Write-Host "Operating System:" $hostOs

        Write-Host "Sorry but this script only works in Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        break
    }
}

function GetSystemInfoFile([string]$systemInfoFile)
{
    if (($systemInfoFile -eq $Null) -or ($systemInfoFile -eq ""))
    {
        $systemInfoFile = Read-Host -Prompt "Please type system info filename and press the `"Enter`" key (Example: systeminfo.txt)"

        Write-Host ""
        return $systemInfoFile
    }
    else 
    {
        return $systemInfoFile
    }
}

function GetFileDestination([string]$fileDestination)
{
    if (($fileDestination -eq $Null) -or ($fileDestination -eq ""))
    {
        $fileDestination = Read-Host -Prompt "Please type the file destination for system info file and press the `"Enter`" key (Example: C:\Users\`$Env:Username\Desktop\)"

        Write-Host ""
        return $fileDestination
    }
    else 
    {
        return $fileDestination
    }
}

function CheckParameters([string]$systemInfoFile, [string]$fileDestination)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-------------------------------------------"
    Write-Host ("systemInfoFile : {0}" -F $systemInfoFile)
    Write-Host ("fileDestination: {0}" -F $fileDestination)
    Write-Host "-------------------------------------------"

    if (($systemInfoFile -eq $Null) -or ($systemInfoFile -eq ""))
    {
        Write-Host "systemInfoFile is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($fileDestination -eq $Null) -or ($fileDestination -eq ""))
    {
        Write-Host "fileDestination is not set." -ForegroundColor Red
        $valid = $False
    }

    Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime

    if ($valid -eq $True)
    {
        Write-Host "All parameter check(s) passed." -ForegroundColor Green

        Write-Host "Finished checking parameters at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "One or more parameters are incorrect." -ForegroundColor Red

        Write-Host "Finished checking parameters at" (Get-Date).DateTime
        Write-Host ""

        break
    }
}

function ExportSystemInfoAsTextFile([string]$systemInfoFile, [string]$fileDestination)
{
    Write-Host "`nExport system info to text file on Windows.`n"
    CheckOsForWindows

    $systemInfoFile = GetSystemInfoFile $systemInfoFile
    $fileDestination = GetFileDestination $fileDestination
    CheckParameters $systemInfoFile $fileDestination

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started exporting system info to text file at" $startDateTime.DateTime

        $systemInfoFilePath = Join-Path $fileDestination $systemInfoFile
        systeminfo | Out-File $systemInfoFilePath
        Get-Content -Path $systemInfoFilePath 

        Write-Host ("Successfully exported system info text file as {0} at this location: {1}" -F $systemInfoFile, $fileDestination) -ForegroundColor Green

        Get-ChildItem -Path $fileDestination

        $finishedDateTime = (Get-Date)
        Write-Host "Finished exporting systme info to text file at" $finishedDateTime.DateTime
        
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host ("Failed to export system info text file as {0} at this location: {1}" -F $systemInfoFile, $fileDestination)

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        
        Get-ChildItem -Path $fileDestination
    }
}

ExportSystemInfoAsTextFile $systemInfoFile $fileDestination
