# Get the directory of the current script
$ScriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Import module using relative path
Import-Module -Name "$ScriptDir\..\..\ELH_Library.psm1"

# Menu Screen
Menu -title "Uninstall Module" -texts @("0: EXIT", "ENTER: View Disc Sace")

# Add an Exit button prompt
$exitChoice = Read-Host -Prompt "ENTER"
if ($exitChoice -eq "0") {
    Menu -title "Exiting script..."
    exit
}
# Assigns moduel name and version to veriables 
$Module = Read-Host -Prompt 'Enter Module Name'
$Version = Read-Host -Prompt 'Enter Version'

# Uninstalls the module specific to the version 
Uninstall-Module -Name $Module -RequiredVersion $Version

# Allows you to confirm if module is still present
Get-Module -Name $Module -ListAvailable

