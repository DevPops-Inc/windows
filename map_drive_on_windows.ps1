#!/bin/powershell

# declare variables
$DriveLetter = Read-Host -Prompt "What letter would you like to map the drive with? (Example: D)"
$PathWay = Read-Host -Prompt "What is the pathway of the drive you wish to map? (Example: \\Network\Share)"

# map drive
New-PSDrive -Name "$DriveLetter" -PSProvider FileSystem -Root "$PathWay" -Persist

# get list of drives
Get-PSDrive
