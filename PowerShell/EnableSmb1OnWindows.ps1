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
        Write-Host "Sorry but this script only runs on Wirndows" -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        break 
    }
}

function EnableSmb1()
{
    Write-Host "`nEnable SMB1 on Windows.`n"

    try
    {
        Enable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -All

        Write-Host "`nSuccessfully enabled SMB1.`n" -ForegroundColor Green
    }
    catch 
    {
        Write-Host "`nFailed to enable SMB1.`n" -ForegroundColor Red
    }
}

EnableSmb1
