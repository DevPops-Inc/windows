# return first recurring character in string 

# you can run this script with: .\ReturnFirstRecurringCharInString.ps1 -string < string > 

[CmdletBinding()]
param(
    [string] [Parameter(Mandatory = $False)] $string = ""
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

function GetString([string]$string)
{
    if (($string -eq $Null) -or ($string -eq ""))
    {
        $string = Read-Host -Prompt "Please type a string you would like the first recurring character for and press `"Enter`" key on Windows or `"return`" key on Mac or Linux (Example: foobar)"

        return $string
    }
    else
    {
        return $string
    }
}

function CheckParameters([string]$string)
{
    Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
    $valid = $True

    Write-Host "Parameter(s):"
    Write-Host "-------------------------"
    Write-Host ("string: {0}" -F $string)
    Write-Host "-------------------------"

    if (($string -eq $Null) -or ($string -eq ""))
    {
        Write-Host "string is not set." -ForegroundColor Red
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

function ReturnFirstRecurringChar([string]$string)
{
    $stringHash= @{}

    foreach ($character in $string.ToCharArray())
    {
        if ($stringHash.ContainsKey($character))
        {
            return $character
        } 
        else 
        {
            $stringHash.Add($character,0)
        }
    }
    
    return '0'
}

function ReturnFirstRecurringCharInString([string]$string)
{
    Write-Host "`nReturn first recurring character in string."
    CheckOs

    $string = GetString $string
    CheckParameters $string

    try 
    {
        $startDateTime = (Get-Date)
        
        Write-Host ("Started returning first recurring character in `"{0}`" string at {1}" -F $string, $startDateTime)

        $bar = ReturnFirstRecurringChar $string
        
        Write-Host ("`nThe first recurring character in `"{0}`" string is `"{1}`"." -F $string, $bar) -ForegroundColor Yellow
        
        $finishedDateTime = (Get-Date)
        
        Write-Host ("`nFinished returning first recurrning character in `"{0}`" string at {1}" -F $string, $finishedDateTime)

        $duration = New-TimeSpan $startDateTime $finishedDateTime

        Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
    }
    catch 
    {
        Write-Host ("Failed to return first recurring character in {0} string" -F $string) -ForegroundColor Red

        Write-Host $_ -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
    }
}

ReturnFirstRecurringCharInString $string
