# create standard user on Windows

# you can run this script with: .\CreateStandardUserOnWindows.ps1 -standardUser < standard user > -password < password > -description < description >

[CmdletBinding()]
param(
      [string]       [Parameter(Mandatory = $False)] $standardUser = ""
    , [securestring] [Parameter(Mandatory = $False)] $password = $Null
    , [string]       [Parameter(Mandatory = $False)] $description = ""
)

function CheckOsForWindows()
{
  Write-Host "`nCheck operation system at" (Get-Date).DateTime
  $hostOs = [System.Environment]::OSVersion.Platform

  if ($hostOs -eq "Win32NT")
  {
    Write-Host "Operating System: " (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -ForegroundColor Green

    Write-Host "Finished checking operating system at" (Get-Date).DateTime
    Write-Host ""
  }
  else 
  {
    Write-Host "Operating System: " $hostOs

    Write-Host "Sorry but this script only works in Windows." -ForegroundColor Red

    Write-Host "Finished checking operating system at" (Get-Date).DateTime
    Write-Host ""
    break
  }
}

function GetStandardUser([string]$standardUser)
{
  if (($standardUser -eq $Null) -or ($standardUser -eq ""))
    {
      $standardUser = Read-Host -Prompt "`nPlease type the standard user name and press `"Enter`" key (Example: Standard.User)"

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
    $password = Read-Host -Prompt "`nPlease type the password and press `"Enter`" key (Example: Password1234)" -AsSecureString

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
    $description = Read-Host -Prompt "`nPlease type the description and press `"Enter`" key (Example: Standard User)"

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
  Write-Host "`nStarted checking parameters at" (Get-Date).DateTime
  $valid = $True

  Write-Host "`nParameters:"
  Write-Host "----------------------------------------"
  Write-Host ("standardUser: {0}" -F $standardUser)
  Write-Host ("password    : {0}" -F "***")
  Write-Host ("description : {0}" -F $description)
  Write-Host "----------------------------------------"

  if (($standardUser -eq $Null) -or ($standardUser -eq ""))
  {
    Write-Host "standardUser is not set." -ForegroundColor Red
    $valid = $False
  }

  if (($password -eq $Null) -or ($password -eq ""))
  {
    Write-Host "password is not set." -ForegroundColor
    $valid = $False
  }

  if (($description -eq $Null) -or ($description -eq ""))
  {
    Write-Host "description is not set." -ForegroundColor Red
    $valid = $False
  }

  Write-Host "Finished checking parameters at" (Get-Date).DateTime

  if ($valid -eq $True)
  {
    Write-Host "All parameter checks passed.`n"  -ForegroundColor Green
  }
  else 
  {
    Write-Host "One or more parameters are incorrect, exiting script." -ForegroundColor Red

    exit -1
  }
}

function CreateStandardUser([string]$standardUser, [securestring]$password, [string]$description)
{
  Write-Host "`nCreate standard user on Windows.`n"
  CheckOsForWindows

  $standardUser = GetStandardUser $standardUser
  $password = GetPassword $password
  $description = GetDescription $description
  CheckParameters $standardUser $password $description

  try 
  {
    $startDateTime = (Get-Date)
    Write-Host "Started creating standard user at" $startDateTime

    # create new user and set password
    New-LocalUser $standardUser -Password $sassword -FullName $standardUser -Description $description

    # set password for new user to never expire
    Set-LocalUser -Name $standardUser -PasswordNeverExpires 1

    # check if new user has been added
    Write-Host ("`nSuccessfully created standard user: {0}`n" -F $standardUser) -ForegroundColor Green

    Write-Host "The users on the this computer are: `n"
    Get-LocalUser

    $finishedDateTime = (Get-Date)
    Write-Host "Finished creating standard user at" $finishedDateTime
    $duration = New-TimeSpan $startDateTime $finishedDateTime

    Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)
  }
  catch 
  {
    Write-Host ("`nFailed to create standard user {0}.`n" -F $standardUser) -ForegroundColor Red

    Write-Host $_ -ForegroundColor Red
    Write-Host $_.ScriptStackTrace -ForegroundColor Red
  }
}

CreateStandardUser $standardUser $password $description
