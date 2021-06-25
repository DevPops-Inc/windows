# create standard user on Windows

# you can run this script with: .\CreateStandardUserOnWindows.ps1 -standardUser < standard user > -password < password > -description < description >

[CmdletBinding()]
param(
      [string] [Parameter(Mandatory = $False)] $standardUser = ""
    , [string] [Parameter(Mandatory = $False)] $password = ""
    , [string] [Parameter(Mandatory = $False)] $description = ""
)

function GetStandardUser([string]$standardUser)
{
  if (($standardUser -eq $Null) -or ($standardUser -eq ""))
    {
      $standardUser = Read-Host -Prompt "`nPlease type the standard user name (Example: Standard.User)"
      return $standardUser
    }
    else 
    {
      return $standardUser
    }
}

function GetPassword([string]$password)
{
  if (($password -eq $Null) -or ($password -eq ""))
  {
    $password = Read-Host -Prompt "`nPlease type the password? (Example: Password1234)"
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
    $description = Read-Host -Prompt "`nPlease type the description (Example: Standard User)"
    return $description
  }
  else
  {
    return $description
  }
}

function CreateStandardUser([string]$standardUser, [string]$password, [string]$description)
{
  Write-Host "`nCreate standard user on Windows.`n"
  
  $standardUser = GetStandardUser $standardUser
  $password = GetPassword $password
  $description = GetDescription $description

  try 
  {
    # create new user and set password
    New-LocalUser $standardUser -Password $sassword -FullName $standardUser -Description $description

    # set password for new user to never expire
    Set-LocalUser -Name $standardUser -PasswordNeverExpires 1

    # check if new user has been added
    Write-Host ("`nStandard user {0} has been created.`n" -F $standardUser) -ForegroundColor Green

    Write-Host "The users on the this computer are: `n"
    Get-LocalUser
  }
  catch 
  {
    Write-Host ("`nFailed to create standard user {0}.`n" -F $standardUser) -ForegroundColor Red
  }
}

CreateStandardUser $standardUser $password $description
