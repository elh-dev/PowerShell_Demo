# Import module using relative path
Import-Module -Name "$ScriptDir\ELH_Library.psm1"

# Display initial menu
Menu -title "Restart" -texts @("1: Confirm", "0: Reject")

$userConfirmation = Read-Host -Prompt "Enter"

# Check the user's response
if ($userConfirmation -eq "1") {
    # Initiate the restart
    Stop-Computer -Force
    $option = "Restarting..."
} else {
    $option = "Aborted."
}

Menu -title $option