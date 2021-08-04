# Windows Server Back up

# you can run this script with: .\BackUpWinServ.ps1 -fileSpecPath < file spec path > -volumePath < volume path > 

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $fileSpecPath = ""
    , [string] [Parameter(Mandatory = $False)] $volumePath = ""
)

function GetFileSpecPath([string]$fileSpecPath)
{
    if (($fileSpecPath -eq $Null) -or ($fileSpecPath -eq ""))
    {
        $fileSpecPath = Read-Host -Prompt "Please type the file spec path and press `"Enter`" key (Example: C:\important)"

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

        return $volumePath
    }
    else 
    {
        return $volumePath
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

function BackUpWindowsServer([string]$fileSpecPath, [string]$volumePath)
{
    Write-Host "`nWindows Server Back up.`n"
    CheckOsForWindows

    $fileSpecPath = GetFileSpecPath $fileSpecPath
    $volumePath = GetVolumePath $volumePath
    
    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Starting backing up Windows server at:" $startDateTime

        $policy = New-WBPolicy  
        $fileSpec = New-WBFileSpec -FileSpec $fileSpecPath
        $backupLocation = New-WBBackupTarget -VolumePath $volumePath
        $BUpolicy = Get-WBPolicy

        Add-WBFileSpec -Policy $policy -FileSpec $filespec  
        Add-WBBackupTarget -Policy $policy -Target $backupLocation  
        Set-WBSchedule -Policy $policy 09:00  
        Set-WBPolicy -Policy $policy
        Start-WBBackup -Policy $BUpolicy
        
        Write-Host "Successfully backed up Windows Server." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "`nFinished Windows maintenance at:" $finishedDateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime
        
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host "Failed to back up Windows Server." -ForegroundColor Red
        Write-Host $_ -ForegroundColor -Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

BackUpWindowsServer $fileSpecPath $volumePath
