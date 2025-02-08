# Get the directory of the current script
$ScriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Import module using relative path
Import-Module -Name "$ScriptDir\..\ELH_Library.psm1"

# Menu Screen
Menu -title 'Extract from ZIP' -texts @("0: EXIT", "ENTER: View Disc Sace")

# Add an Exit button prompt
$exitChoice = Read-Host -Prompt "ENTER"
if ($exitChoice -eq "0") {
    Menu -title "Exiting script..."
    exit
}


$SourceDirectory = Read-Host -prompt 'Source Directory'
$DestinationDirectory= Read-Host -prompt 'Destination Directory'

Expand-Archive -Path $SourceDirectory -DestinationPath $DestinationDirectory

# tests if exe was created 
if (Test-Path -Path $DestinationDirectory) {
    Menu -title "Extract Succesfull"
} else {
    Menu -title "Extract Failed"
}