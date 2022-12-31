# output Windows updates list onto desktop

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
        Write-Host "Your operating system is:" $hostOs
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system at" (Get-Date).DateTime
        Write-Host ""
        
        break
    }
}

function OutputWindowsUpdateListOntoDesktop()
{
    Write-Host "`nOutput list of Windows updates as text file onto desktop.`n"
    CheckOsForWindows

    try 
    {
        Get-Hotfix | Out-File C:\Users\$env:USERNAME\Desktop\windowsupdates.txt 
        
        Write-Host "Successfully output windows update list onto desktop." -ForegroundColor Green

        Get-ChildItem C:\Users\$env:USERNAME\Desktop\windowsupdates.txt 
    }
    catch 
    {
        Write-Host "Failed to output Windows update list onto desktop." -ForegroundColor Red

        Get-ChildItem C:\Users\$env:USERNAME\Desktop\
    }
}

OutputWindowsUpdateListOntoDesktop
