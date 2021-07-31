# unpack file on Windows 

# you can run this script with: .\UnpackFileOnWindows.ps1 -sourceFilePath < source path > -destinationPath < destination path > 

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $sourceFilePath = ""
    , [string] [Parameter(Mandatory = $False)] $destinationPath = ""
)

function GetSourceFilePath([string]$sourceFilePath)
{
    if (($sourceFilePath -eq $Null) -or ($sourceFilePath -eq ""))
    {
        $sourceFilePath = Read-Host -Prompt "Please type the filepath of the file you wish to unpack and press `"Enter`" key (Example: C:\vic.zip)"

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

        return $destinationPath
    }
    else
    {
        return $destinationPath
    }
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

function UnpackFile([string]$sourceFilePath, [string]$destinationPath)
{
    Write-Host "`nUnpack file on Windows.`n"
    CheckOsForWindows

    $sourceFilePath = GetSourceFilePath $sourceFilePath
    $destinationPath = GetDestinationPath $destinationPath

    try 
    {
        Expand-Archive -LiteralPath $sourceFilePath -destinationPath $destinationPath

        Write-Host ("Successfully unpacked {0} in {1}" -F $sourceFilePath, $destinationPath) -ForegroundColor Green

        Get-ChildItem-Path $destinationPath
    }
    catch
    {
        Write-Host ("Failed to unpack {0} in {1}" -F $sourceFilePath, $destinationPath) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

UnpackFile $sourceFilePath $destinationPath
