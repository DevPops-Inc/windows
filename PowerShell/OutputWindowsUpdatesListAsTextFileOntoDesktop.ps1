# output Windows updates list onto desktop

function CheckOsForWindows()
{
    Write-Host "`nChecking operating system..."
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "You are running this script on Windows." -ForegroundColor Green
    }
    else 
    {
        Write-Host "Your operating system is:" $hostOs
        
        Write-Host "Sorry but this script only works on Windows." -ForegroundColor Red

        Write-Host "Finished checking operating system.`n"
        break
    }
    Write-Host "Finished checking operating system.`n"
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
