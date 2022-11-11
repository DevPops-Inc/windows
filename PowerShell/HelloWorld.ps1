# hello world exercise in PowerShell

function CheckOs()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green
    }
    else 
    {
        Write-Host "Operating System:" $hostOs -ForegroundColor Green
    }

    Write-Host "Finished checking operating system at" (Get-Date).DateTime
    Write-Host ""
}

function HelloWorld()
{
    Write-Host "`nHello World Exercise in PowerShell.`n"
    CheckOs

    $colors = 'White', 'DarkRed', 'Red', 'Yellow', 'DarkYellow', 'Green', 'DarkGreen', 'DarkBlue', 'Blue', 'DarkCyan', 'Cyan', 'Magenta', 'DarkMagenta', 'Black'

    try 
    {
        $startDateTime = (Get-Date)
        Write-Host "Started running Hello World exercise at" $startDateTime

        foreach ($color in $colors)
        {
            Write-Host -ForegroundColor $color "Hello, World!"
            Start-Sleep -s 1
        }
        Write-Host "Successfully ran Hello World exercise!" -ForegroundColor Green

        $finishedDateTime = (Get-Date)
        Write-Host "Finished running Hello World exercise at" $finishedDateTime
        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host "`nFailed to run Hello World exercise." -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

HelloWorld
