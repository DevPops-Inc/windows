# enable SMB1 on Windows 


function CheckOsForWindows()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
    }
    else 
    {
        Write-Host "Operating System:" $hostOs
        throw "Sorry but this script only runs on Wirndows" 
    }
}

function EnableSmb1()
{
    Write-Host "`nEnable SMB1 on Windows.`n"
    CheckOsForWindows

    try
    {
        $startDateTime = (Get-Date)
        Write-Host "Started enabling SMB1 at" $startDateTime.DateTime

        Enable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -All
        Write-Host "Successfully enabled SMB1." -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished enabling SMB1 at" $finishedDateTime.DateTime

        $duration = New-TimeSpan $startDateTime $finishedDateTime
        
        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

        Write-Host ""
    }
    catch 
    {
        Write-Host "Failed to enable SMB1." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Write-Host ""
    }
}

EnableSmb1
