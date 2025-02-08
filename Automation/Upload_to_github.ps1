# Get the directory of the current script
$ScriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Import module using relative path
Import-Module -Name "$ScriptDir\..\ELH_Library.psm1"

# Menu Screen
Menu -title "Upload to GitHub Repository" -texts @("0: EXIT", "ENTER: View Disc Space")

# Add an Exit button prompt
$exitChoice = Read-Host -Prompt "ENTER"
if ($exitChoice -eq "0") {
    Menu -title "Exiting script..."
    exit
}

# Define the directory to monitor
$sourceDirectory = Read-Host -prompt "Enter Repository Path (D:\Games\Helldivers 2)"

$text = Read-Host -prompt "Enter Update Description"

do {
    Menu -title "Post to GitHub" -texts @("1: Configure Git", "2: Pull Master", "3: Update", "0: Exit")
    $option = Read-Host -Prompt "ENTER"  # Read the user's choice
    switch ($option) {
        1 {
            $username = Read-Host -prompt "GitHub Username"
            $email = Read-Host -prompt "Email Address"
            git config --global user.name $username
            git config --global user.email $email
        }
        2 {
            cd $sourceDirectory
            git pull origin master
            # Handle merge conflicts if they arise
            $conflicts = git diff --name-only --diff-filter=U
            foreach ($conflict in $conflicts) {
                Write-Output "Resolve conflict in: $conflict"
                # You might want to open the file in an editor to resolve the conflict
                # After resolving conflicts, add and commit the changes
                git add $conflict
            }
            git commit -m "Resolved merge conflicts"
            git push origin master
        }
        3 {
            cd $sourceDirectory
            git status
            git add .
            git commit -m $text
            git push
        }
        0 {
            Menu -title "Exiting script..."
            exit
        }
        default {
            Write-Output "Invalid choice. Please try again."
        }
    }
} while ($option -ne "0")
