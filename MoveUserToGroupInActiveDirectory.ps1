# move user to group in Active Directory 

# you run this script with: .\MoveUserToGroupInActiveDirectory.ps1 -username < username > -newGroup < new group > -oldGroup < old group > 

[CmdletBinding()]
param(
     [string] [Parameter(Mandatory = $False)] $username = ""
   , [string] [Parameter(Mandatory = $False)] $newGroup = ""
   , [string] [Parameter(Mandatory = $False)] $oldGroup = ""
)

function GetUserName([string]$username)
{
   if (($username -eq $Null) -or ($username -eq ""))
   {
      $username = Read-Host -Prompt "Please type the username you would like to move to new group"

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
      $newGroup = Read-Host -Prompt ("Please type the new group you wish to move {0} to" -F $username)

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
      $oldGroup = Read-Host -Prompt ("Please type the old group you are moving {0} from" -F $username)

      return $oldGroup
   }
   else
   {
      return $oldGroup
   }
}

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

function MoveUserToGroupInActiveDirectory([string]$username, [string]$newGroup, [string]$oldGroup)
{
   Write-Host "`nMove user to group in Active Directory.`n"
   CheckOsForWindows

   $username = GetUserName $username
   $newGroup = GetNewGroup $newGroup
   $oldGroup = GetOldGroup $oldGroup

   try 
   {
      # do the matching, add to new group and remove from original
      Get-ADUserNames `
            -UserNamesString $username `
            -Separator "`n" |
         %{Add-ADPrincipalGroupMembership `
            -MemberOf $newGroup `
            -Identity $_.ADUser `
            -PassThru} |
         %{Remove-ADPrincipalGroupMembership `
            -MemberOf $oldGroup `
            -Identity $_.ADUser}

      Write-Host ("Successfully moved {0} from old group {1} to new group {2}." -F $username, $oldGroup, $newGroup) -ForegroundColor Green
   }
   catch 
   {
      Write-Host ("Failed to move {0} from old group {1} to new group {2}." -F $username, $oldGroup, $newGroup) -ForegroundColor Red
   }
}

MoveUserToGroupInActiveDirectory $username $newGroup $oldGroup
