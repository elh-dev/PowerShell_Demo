# Get the directory of the current script
$ScriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Import module using relative path
Import-Module -Name "$ScriptDir\..\ELH_Library.psm1"


# Display initial menu
Menu -title "Shutdown" -texts @("1: Confirm", "0: Reject")

$userConfirmation = Read-Host -Prompt "Enter"

# Check the user's response
if ($userConfirmation -eq "1") {
    # Initiate the restart
    Stop-Computer -Force
    Menu -title"Initiating..."
} else {
    Menu -title "Aborted."
}
