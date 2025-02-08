# Get the directory of the current script
$ScriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Import module using relative path
Import-Module -Name "$ScriptDir\..\ELH_Library.psm1"

Menu -title "OS Version" -texts @("0: EXIT", "ENTER: View Disc Sace")

# Add an Exit button prompt
$exitChoice = Read-Host -Prompt "ENTER"
if ($exitChoice -eq "0") {
    Menu -title "Exiting script..."
    exit
}

# retrive OS version and save under veriable 
$osVersion = Get-ComputerInfo | Select-Object -ExpandProperty WindowsVersion

# print details 
Menu -title "Operating System Version" -text @($osVersion)

