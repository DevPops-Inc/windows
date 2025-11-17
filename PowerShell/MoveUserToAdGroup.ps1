# move user to group in Active Directory 

# you run this script with: .\MoveUserToAdGroup.ps1 -username < username > -newGroup < new group > -oldGroup < old group > 

[CmdletBinding()]
param(
   [string] [Parameter(Mandatory = $False)] $username = "", # you can set the username here 
   [string] [Parameter(Mandatory = $False)] $newGroup = "", # you can set the new group here 
   [string] [Parameter(Mandatory = $False)] $oldGroup = "" # you can set the old group here 
)

$ErrorActionPreference = "Stop"

function CheckOsForWin()
{
   Write-Host "Started checking operating system at" (Get-Date).DateTime
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
      throw "Sorry but this script only works on Windows." 
   }
}

function GetUserName([string]$username)
{
   if (($username -eq $Null) -or ($username -eq ""))
   {
      $username = Read-Host -Prompt "Please type the username you would like to move to new group and press `"Enter`" key (Example: software.dev)"

      Write-Host ""
      return $username
   }
   else 
   {
      return $username
   }
}

function GetNewGroup([string]$newGroup)
{
   if (($newGroup -eq $Null) -or ($newGroup -eq ""))
   {
      $newGroup = Read-Host -Prompt ("Please type the new group you wish to move {0} to and press `"Enter`" key (Example: devs)" -F $username)

      Write-Host ""
      return $newGroup
   }
   else
   {
      return $newGroup
   }
}

function GetOldGroup([string]$oldGroup)
{
   if (($oldGroup -eq $Null) -or ($oldGroup -eq ""))
   {
      $oldGroup = Read-Host -Prompt ("Please type the old group you are moving {0} from (Example: sysadmins)" -F $username)

      Write-Host ""
      return $oldGroup
   }
   else
   {
      return $oldGroup
   }
}

function CheckParameters([string]$username, [string]$newGroup, [string]$oldGroup)
{
   Write-Host "Started checking parameter(s) at" (Get-Date).DateTime
   $valid = $True

   Write-Host "Parameter(s):"
   Write-Host "-----------------------------"
   Write-Host ("username: {0}" -F $username)
   Write-Host ("newGroup: {0}" -F $newGroup)
   Write-Host ("oldGroup: {0}" -F $oldGroup)
   Write-Host "-----------------------------"

   if (($username -eq $Null) -or ($username -eq ""))
   {
      Write-Host "username is not set." -ForegroundColor Red
      $valid = $False
   }

   if (($newGroup -eq $Null) -or ($newGroup -eq ""))
   {
      Write-Host "newGroup is not set." -ForegroundColor Red
      $valid = $False
   }

   if (($oldGroup -eq $Null) -or ($oldGroup -eq ""))
   {
      Write-Host "oldGroup is not set." -ForegroundColor Red
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
      throw "One or more parameter checks incorrect, exiting script." 
   }
}

function MoveUserToGroup([string]$username, 
                                          [string]$newGroup, 
                                          [string]$oldGroup)
{
   Write-Host "`nMove user to group in Active Directory.`n"
   CheckOsForWin

   $username = GetUserName $username
   $newGroup = GetNewGroup $newGroup
   $oldGroup = GetOldGroup $oldGroup
   CheckParameters $username $newGroup $oldGroup

   try 
   {
      $startDateTime = (Get-Date)
      
      Write-Host ("Started moving {0} user to {1} group at {2}" -F $username, $newGroup, $startDateTime)

      # do the matching, add to new group and remove from original
      Get-ADUserNames `
            -UserNamesString $username `
            -Separator "`n" |
         ForEach-Object{Add-ADPrincipalGroupMembership `
            -MemberOf $newGroup `
            -Identity $_.ADUser `
            -PassThru} |
         ForEach-Object{Remove-ADPrincipalGroupMembership `
            -MemberOf $oldGroup `
            -Identity $_.ADUser}

      Write-Host ("Successfully moved {0} from old group {1} to new group {2}." -F $username, $oldGroup, $newGroup) -ForegroundColor Green

      $finishedDateTime = (Get-Date)
      
      Write-Host ("Finished moving {0} user to {1} group at {2}" -F $username, $newGroup, $finishedDateTime)

      $duration = New-TimeSpan $startDateTime $finishedDateTime

      Write-Host ("Total execution time: {0} hours {1} minutes {2} seconds" -F $duration.Hours, $duration.Minutes, $duration.Seconds)

      Write-Host ""
   }
   catch 
   {
      Write-Host ("Failed to move {0} from old group {1} to new group {2}." -F $username, $oldGroup, $newGroup) -ForegroundColor Red
      
      Write-Host $_ -ForegroundColor Red
      Write-Host $_.ScriptStackTrace -ForegroundColor Red
      Write-Host ""
   }
}

MoveUserToGroup $username $newGroup $oldGroup
