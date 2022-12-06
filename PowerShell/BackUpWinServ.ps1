# Windows Server Back up

# you can run this script with: .\BackUpWinServ.ps1 -fileSpecPath < file spec path > -volumePath < volume path > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $fileSpecPath = "", # you can set the file spec path here
    [string] [Parameter(Mandatory = $False)] $volumePath   = "" # you can set the volume path here
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
        
        Write-Host "Sorry but this script only runs on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""

        break
    }
}

function GetFileSpecPath([string]$fileSpecPath)
{
    if (($fileSpecPath -eq $Null) -or ($fileSpecPath -eq ""))
    {
        $fileSpecPath = Read-Host -Prompt "Please type the file spec path and press `"Enter`" key (Example: C:\important)"

        Write-Host ""
        return $fileSpecPath
    }
    else
    {
        return $fileSpecPath
    }
}

function GetVolumePath([string]$volumePath)
{
    if (($volumePath -eq $Null) -or ($volumePath -eq ""))
    {
        $volumePath = Read-Host -Prompt "Please type the volume path and press `"Enter`" key (Example: E:)"

        Write-Host ""
        return $volumePath
    }
    else 
    {
        return $volumePath
    }
}

function CheckParameters([string]$fileSpecPath, [string]$volumePath)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-------------------------------------"
    Write-Host ("fileSpecPath: {0}" -F $fileSpecPath)
    Write-Host ("volumePath  : {0}" -F $volumePath)
    Write-Host "-------------------------------------"

    if (($fileSpecPath -eq $Null) -or ($fileSpecPath -eq ""))
    {
        Write-Host "fileSpecPath is not set." -ForegroundColor Red
        $valid = $False
    }

    if (($volumePath -eq $Null) -or ($volumePath -eq ""))
    {
        Write-Host "volumePath is not set." -ForegroundColor Red
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
        Write-Host "One or more parameters are incorrect." -ForegroundColor Red

        Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
        Write-Host ""

        break
    }
}

function BackUpWindowsServer([string]$fileSpecPath, [string]$volumePath)
{
    Write-Host "`nWindows Server Back up.`n"
    CheckOsForWindows

    $fileSpecPath = GetFileSpecPath $fileSpecPath
    $volumePath   = GetVolumePath $volumePath
    CheckParameters $fileSpecPath $volumePath
    
    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Starting backing up Windows server at:" $startDateTime.DateTime

        $policy         = New-WBPolicy  
        $fileSpec       = New-WBFileSpec -FileSpec $fileSpecPath
        $backupLocation = New-WBBackupTarget -VolumePath $volumePath
        $BUpolicy       = Get-WBPolicy

        Add-WBFileSpec -Policy $policy -FileSpec $filespec  
        Add-WBBackupTarget -Policy $policy -Target $backupLocation  
        Set-WBSchedule -Policy $policy 09:00  
        Set-WBPolicy -Policy $policy
        Start-WBBackup -Policy $BUpolicy
        
        Write-Host "Successfully backed up Windows Server." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished Windows maintenance at:" $finishedDateTime.DateTime
        
        $duration = New-TimeSpan $startDateTime $finishedDateTime
        
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch 
    {
        Write-Host "Failed to back up Windows Server." -ForegroundColor Red
        Write-Host $_ -ForegroundColor -Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

BackUpWindowsServer $fileSpecPath $volumePath
