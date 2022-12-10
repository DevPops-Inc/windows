# return first recurring character in string 

# you can run this script with: .\ReturnFirstRecurringCharInString.ps1 -foo < string > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $foo = ""
)

function CheckOs()
{
    Write-Host "Started checking operating system at" (Get-Date).DateTime
    $hostOs = [System.Environment]::OSVersion.Platform

    if ($hostOs -eq "Win32NT")
    {
        Write-Host "Operating System:" (Get-Instance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green
    }
    else
    {
        Write-Host "Operating System:" $hostOs -ForegroundColor Green
    }

    Write-Host "Finished checking operating system at" (Get-Date).DateTime
    Write-Host ""
}

function GetString([string]$foo)
{
    if (($foo -eq $Null) -or ($foo -eq ""))
    {
        $foo = Read-Host -Prompt "Please type a string you would like the first recurring character for and press `"Enter`" key on Windows or `"return`" key on Mac or Linux (Example: foobar)"

        return $foo
    }
    else
    {
        return $foo
    }
}

function CheckParameters([string]$foo)
{
    Write-Host "`nStarted checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "`nParameter(s):"
    Write-Host "-------------------"
    Write-Host ("foo: {0}" -F $foo)
    Write-Host "-------------------"

    if (($foo -eq $Null) -or ($foo -eq ""))
    {
        Write-Host "foo is not set." -ForegroundColor Red
        $valid = $False
    }

    Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime

    if ($valid -eq $True)
    {
        Write-Host "All parameter check(s) passed.`n" -ForegroundColor Green
    }
    else 
    {
        Write-Host "One or more parameters are incorrect, exiting script." -ForegroundColor Red

        exit -1
    }
}

function ReturnFirstRecurringChar([string]$foo)
{
    $fooHash= @{}

    foreach ($character in $foo.ToCharArray())
    {
        if ($fooHash.ContainsKey($character))
        {
            return $character
        } 
        else 
        {
            $fooHash.Add($character,0)
        }
    }
    
    return '0'
}

function ReturnFirstRecurringCharInString([string]$foo)
{
    Write-Host "`nReturn first recurring character in string."
    CheckOs

    $foo = GetString $foo
    CheckParameters $foo

    try 
    {
        $startDateTime = (Get-Date)
        
        Write-Host ("Started returning first recurring character in `"{0}`" string at {1}" -F $foo, $startDateTime)

        $bar = ReturnFirstRecurringChar $foo
        
        Write-Host ("`nThe first recurring character in `"{0}`" string is `"{1}`"." -F $foo, $bar) -ForegroundColor Yellow
        
        $finishedDateTime = (Get-Date)
        
        Write-Host ("`nFinished returning first recurrning character in `"{0}`" string at {1}" -F $foo, $finishedDateTime)

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host ("Failed to return first recurring character in {0} string" -F $foo) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

ReturnFirstRecurringCharInString $foo
