# Get the directory of the current script
$ScriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Import module using relative path
Import-Module -Name "$ScriptDir\..\ELH_Library.psm1"

# Menu Screen
Menu -title "Installed Softwear" -texts @("0: EXIT", "ENTER: View Disc Sace")

# Add an Exit button prompt
$exitChoice = Read-Host -Prompt "ENTER"
if ($exitChoice -eq "0") {
    Menu -title "Exiting script..."
    exit
}

$installedSoftware = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object -Property DisplayName, DisplayVersion
  
# print details 

Write-Output $installedSoftware