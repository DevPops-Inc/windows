# unpack file on Windows 

# you can run this script with: .\UnpackFileOnWindows.ps1 -sourceFilePath < source path > -destinationPath < destination path > 

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $sourceFilePath = ""
    , [string] [Parameter(Mandatory = $False)] $destinationPath = ""
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
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        break
    }
}

function GetSourceFilePath([string]$sourceFilePath)
{
    if (($sourceFilePath -eq $Null) -or ($sourceFilePath -eq ""))
    {
        $sourceFilePath = Read-Host -Prompt "Please type the filepath of the file you wish to unpack and press `"Enter`" key (Example: C:\vic.zip)"

        Write-Host ""
        return $sourceFilePath
    }
    else 
    {
        return $sourceFilePath
    }
}

function GetDestinationPath([string]$destinationPath)
{
    if (($destinationPath -eq $Null) -or ($destinationPath -eq ""))
    {
        $destinationPath = Read-Host -Prompt "Please type the file path you want the contents of the file to go and press `"Enter`" key (Example: C:\)"

        Write-Host ""
        return $destinationPath
    }
    else
    {
        return $destinationPath
    }
}

function CheckParameters([string]$sourceFilePath, [string]$destinationPath)
{
    Write-Host "Started checking parameters at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameters:"
    Write-Host "-------------------------------------------"
    Write-Host ("sourceFilePath : {0}" -F $sourceFilePath)
    Write-Host ("destinationPath: {0}" -F $destinationPath)
    Write-Host "-------------------------------------------"

    if (($sourceFilePath -eq $Null) -or ($sourceFilePath -eq ""))
    {
        Write-Host "sourceFilePath is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($destinationPath -eq $Null) -or ($destinationPath -eq ""))
    {
        Write-Host "destinationPath is not set." -ForegroundColor Red
        $valid = $False
    }

    if ($valid -eq $True)
    {
        Write-Host "All parameter checks passed." -ForegroundColor Green
    }
    else 
    {
        Write-Host "One or more parameter checks are incorrect, exiting script." -ForegroundColor Red

        break
    }

    Write-Host "Finished checking parameters at" (Get-Date).DateTime
    Write-Host ""
}

function UnpackFile([string]$sourceFilePath, [string]$destinationPath)
{
    Write-Host "`nUnpack file on Windows.`n"
    CheckOsForWindows

    $sourceFilePath = GetSourceFilePath $sourceFilePath
    $destinationPath = GetDestinationPath $destinationPath
    CheckParameters $sourceFilePath $destinationPath

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started unpacking file at" $startDateTime

        Expand-Archive -LiteralPath $sourceFilePath -destinationPath $destinationPath

        Write-Host ("Successfully unpacked {0} in {1}" -F $sourceFilePath, $destinationPath) -ForegroundColor Green

        Get-ChildItem-Path $destinationPath

        $finishedDateTime = (Get-Date)
        Write-Host "Finished unpacking file at" $finishedDateTime
    }
    catch
    {
        Write-Host ("Failed to unpack {0} in {1}" -F $sourceFilePath, $destinationPath) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

UnpackFile $sourceFilePath $destinationPath
