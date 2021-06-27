# export system info to text file

# you can run this script with: .\ExportSystemInfoAsTextFileOnWindows.ps1 -systemInfoFile < system info filename > -fileDestination < file destination >

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $systemInfoFile = ""
    , [string] [Parameter(Mandatory = $False)] $fileDestination = ""
)

function GetSystemInfoFile([string]$systemInfoFile)
{
    if (($systemInfoFile -eq $Null) -or ($systemInfoFile -eq ""))
    {
        $systemInfoFile = Read-Host -Prompt "`nPlease type filename for system info text file or press `"Ctrl`" and `"C`" keys to accept default filename: systeminfo.txt`n"

        return $systemInfoFile
    }
    else 
    {
        $systemInfoFile = "systeminfo.txt"
        return $systemInfoFile
    }
}

function GetFileDestination([string]$fileDestination)
{
    if (($fileDestination -eq $Null) -or ($fileDestination -eq ""))
    {
        $fileDestination = Read-Host -Prompt "`nPlease type file destination for system info file or press `"Ctrl`" and `"C`" keys to accept destination as desktop.`n"

        return $fileDestination
    }
    else 
    {
        $fileDestination = C:\Users\$Env:Username\Desktop\

        return $fileDestination
    }
}

function CheckOsForWindows()
{
    Write-Host "Checking operating system...`n"

    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "You are running this script on Windows.`n" -ForegroundColor Green
    }
    else 
    {
        Write-Host "Your operating system is:" $hostOs
        
        Write-Host "Sorry but this script only works on Windows.`n" -ForegroundColor Red

        break
    }
    Write-Host "Finished checking operating system.`n"
}

function ExportSystemInfoAsTextFile([string]$systemInfoFile, [string]$fileDestination)
{
    Write-Host "`nExport system info to text file on Windows.`n"

    CheckOsForWindows

    try
    {
        systeminfo | Out-File $fileDestination + "\" $systemInfoFile

        Write-Host ("`nSuccessfully exported system info text file as {0} at this location: {1}`n" -F $systemInfoFile, $fileDestination) -ForegroundColor Green

        Get-ChildItem -Path $fileDestination
    }
    catch
    {
        Write-Host ("`nFailed to export system info text file as {0} at this location: {1}`n" -F $systemInfoFile, $fileDestination)

        Get-ChildItem -Path $fileDestination
    }
}

ExportSystemInfoAsTextFile $systemInfoFile $fileDestination
