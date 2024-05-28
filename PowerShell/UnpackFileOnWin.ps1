# unpack file on Windows 

# you can run this script with: .\UnpackFileOnWin.ps1 -sourceFilePath '< source path >' -destinationPath '< destination path >' 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $sourceFilePath  = "", 
    [string] [Parameter(Mandatory = $False)] $destinationPath = ""
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
        throw "Sorry but this script only works on Windows." 
    }
}

function GetSourceFilePath([string]$sourceFilePath)
{
    if (($sourceFilePath -eq $Null) -or ($sourceFilePath -eq ""))
    {
        $sourceFilePath = Read-Host -Prompt "Please type the filepath of the file you wish to unpack and press the `"Enter`" key (Example: C:\vic.zip)"

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
        $destinationPath = Read-Host -Prompt "Please type the file path you want the contents of the file to go and press the `"Enter`" key (Example: C:\)"

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
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
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
        Write-Host "All parameter check(s) passed." -ForegroundColor Green

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        throw "One or more parameter checks are incorrect."
    }
}

function UnpackFile([string]$sourceFilePath, [string]$destinationPath)
{
    Write-Host "`nUnpack file on Windows.`n"
    CheckOsForWin

    $sourceFilePath = GetSourceFilePath $sourceFilePath
    $destinationPath = GetDestinationPath $destinationPath
    CheckParameters $sourceFilePath $destinationPath

    if (-Not (Test-Path -Path $sourceFilePath))
        {
            throw ("{0} isn't valid." -F $sourceFilePath)
        }

    if ((Test-Path -Path $destinationPath))
    {
        throw ("{0} already exists." -F $destinationPath)
    }

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started unpacking files at" $startDateTime.DateTime

        Expand-Archive -LiteralPath $sourceFilePath -destinationPath $destinationPath

        Get-ChildItem -Path $destinationPath | Format-Table -AutoSize

        Write-Host ("Successfully unpacked file in {0}" -F $destinationPath) -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished unpacking file at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime
        
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch
    {
        Write-Host ("Failed to unpack {0} in {1}" -F $sourceFilePath, $destinationPath) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

UnpackFile $sourceFilePath $destinationPath
