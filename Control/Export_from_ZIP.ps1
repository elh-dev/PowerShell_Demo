# Import module using relative path
Import-Module -Name "$ScriptDir\ELH_Library.psm1"

Menu -title 'Extract from ZIP'
$SourceDirectory = Read-Host -prompt 'Source Directory'
$DestinationDirectory= Read-Host -prompt 'Destination Directory'

Expand-Archive -Path $SourceDirectory -DestinationPath $DestinationDirectory

# tests if exe was created 
if (Test-Path -Path $DestinationDirectory) {
    Menu -title "Extract Succesfull"
} else {
    Menu -title "Extract Failed"
}