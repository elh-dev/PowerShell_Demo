# Menu Function
Import-Module -Name "C:\Code\PowerShell_Code\ELH_UI\ELH_Library.psm1"



do {
    
    # Displaying the menu
    Menu -title "Command Menu" -texts @(
        "1: Automation",
        "2: Control",
        "3: Conversion",
        "4: Game",    
        "0: EXIT"
    )

    # User Input
    $option = Read-Host -Prompt "ENTER"
    

    if ($option -eq 0) {
        exit
    }


    switch ($option) {
        1 { 
            Menu -title "Automation" -texts @(
                "1: Copy to Steam Library",
                "0: EXIT")
        }

        2 {
            Menu -title "Control" -texts @(
                "1. Module",
                "2. Path",
                "3. Export from ZIP",        
                "4. Shutdown",
                "5: Restart",
                "6. ShortCut",
                "7. Quit App Force",
                "0: EXIT")
        }

        3 {
            Menu -title "Converter" -texts @(
                "1: HEIC_to_PNG",
                "0: EXIT"
            )
        } 
        
        4 {
            Menu -title "Game" -texts @(
                "1: DND game",
                "2: Q&A",
                "0: EXIT"
            ) 
        }
        
    }
    
    $option1 = Read-Host -prompt "Enter"

    

    $choice2 = Read-Host -Prompt "ENTER"
    if ($choice1 -eq "1") {
        $auto = Read-Host -prompt "ENTER"
        switch ($auto) {
            1 { .  "C:\Code\PowerShell_Code\ELH_UI\Automation\Copy_to_Steam.ps1" }
            0 {
                return
            }
            Default {}
        }
    }
    # Conditional Execution
    if ($option1 -eq "2") {
        switch ($control) {
            1 {
                Menu -title "Module" -texts @(
                "1: Unistall Module",
                "0: EXIT"
            ) 
            }
            2 {
                Menu -title "Path" -texts @(
                "1: Add to Path",
                "0: EXIT"
            ) 
             }
            3 {
                . "C:/Code/PowerShell_Code/ELH_UI/Control/Export_from_ZIP.ps1"
            }
           
            0 {
                Menu -texts @("Goodbye!")
                break  # Added break in both places
            }
            default {
                Write-Output "Invalid choice. Please try again."
            }
        }
    } elseif ($choice1 -eq "2") {
        switch ($choice2) {
            1 {
                . "C:/Code/PowerShell_Code/Commands/Converters/HEIC_to_PNG_ConverterMk2.ps1"  # Corrected
            }
            0 {
                Menu -texts @("Goodbye!")
                break  # Added break in both places;
            }
            default {
                Write-Output "Invalid choice. Please try again."
            }
        }
    } 
} while ($choice1 -ne "0") # Correct choice variable
