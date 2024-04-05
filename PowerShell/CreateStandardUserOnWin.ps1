# create standard user on Windows

# run this script as admin: Start-Process PowerShell -Verb RunAs

# you can run this script with: .\CreateStandardUserOnWin.ps1 -standardUser < standard user > -password < password > -description < description >

[CmdletBinding()]
param(
  [string]       [Parameter(Mandatory = $False)] $standardUser = "", # you can set the username here 
  [securestring] [Parameter(Mandatory = $False)] $password     = $Null, # you can set the password here 
  [string]       [Parameter(Mandatory = $False)] $description  = "" # you can 
)

function CheckOsForWin()
{
  Write-Host "Started checking operation system at" (Get-Date).DateTime
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
    throw "Sorry but this script only works in Windows." 
  }
}

function GetStandardUser([string]$standardUser)
{
  if (($standardUser -eq $Null) -or ($standardUser -eq ""))
    {
      $standardUser = Read-Host -Prompt "Please type the standard user name and press `"Enter`" key (Example: Standard.User)"

      Write-Host ""
      return $standardUser
    }
    else 
    {
      return $standardUser
    }
}

function GetPassword([securestring]$password)
{
  if (($password -eq $Null) -or ($password -eq ""))
  {
    $password = Read-Host -Prompt "Please type the password and press `"Enter`" key (Example: Password1234)" -AsSecureString

    Write-Host ""
    return $password
  }
  else 
  {
    return $password
  }
}

function GetDescription([string]$description)
{
  if (($description -eq $Null) -or ($description -eq ""))
  {
    $description = Read-Host -Prompt "Please type the description and press `"Enter`" key (Example: Standard User)"

    Write-Host ""
    return $description
  }
  else
  {
    return $description
  }
}

function CheckParameters([string]      $standardUser, 
                         [securestring]$password, 
                         [string]      $description)
{
  Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
  $valid = $True

  Write-Host "Parameter(s):"
  Write-Host "-------------------------------------"
  Write-Host ("standardUser: {0}" -F $standardUser)
  Write-Host ("password    : {0}" -F "***")
  Write-Host ("description : {0}" -F $description)
  Write-Host "-------------------------------------"

  if (($standardUser -eq $Null) -or ($standardUser -eq ""))
  {
    Write-Host "standardUser is not set." -ForegroundColor Red
    $valid = $False
  }

  if (($password -eq $Null) -or ($password -eq ""))
  {
    Write-Host "password is not set." -ForegroundColor Red
    $valid = $False
  }

  if (($description -eq $Null) -or ($description -eq ""))
  {
    Write-Host "description is not set." -ForegroundColor Red
    $valid = $False
  }

  if ($valid -eq $True)
  {
    Write-Host "All parameter check(s) passed.`n"  -ForegroundColor Green

    Write-Host "Finished checking parameter(s) at" (Get-Date).DateTime
    Write-Host ""
  }
  else 
  {
    throw "One or more parameters are incorrect." 
  }
}

function CreateStandardUser([string]$standardUser, [securestring]$password, [string]$description)
{
  Write-Host "`nCreate standard user on Windows.`n"
  CheckOsForWindows

  $standardUser = GetStandardUser $standardUser
  $password     = GetPassword $password
  $description  = GetDescription $description
  CheckParameters $standardUser $password $description

  try 
  {
    $startDateTime = (Get-Date)
    Write-Host ("Started creating {0} at {1}" -F $standardUser, $startDateTime.DateTime)

    New-LocalUser $standardUser -Password $password -FullName $standardUser -Description $description
    Set-LocalUser -Name $standardUser -PasswordNeverExpires 1
    Write-Host "The users on the this computer are:" (Get-LocalUser) -ForegroundColor Blue
    Write-Host ("Successfully created {0}" -F $standardUser) -ForegroundColor Green

    $finishedDateTime = (Get-Date)
    Write-Host ("Finished creating {0} at {1}" -F $standardUser, $finishedDateTime.DateTime)
    
    $duration = New-TimeSpan $startDateTime $finishedDateTime

    Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

    Write-Host ""
  }
  catch 
  {
    Write-Host ("Failed to create standard user {0}." -F $standardUser) -ForegroundColor Red
    Write-Host $_ -ForegroundColor Red
    Write-Host $_.ScriptStackTrace -ForegroundColor Red
    Write-Host ""
  }
}

CreateStandardUser $standardUser $password $description
