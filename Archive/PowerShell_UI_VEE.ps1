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
    $mainOption = Read-Host -Prompt "ENTER"

    if ($mainOption -eq 0) {
        exit
    }

    switch ($mainOption) {
        1 {
            Menu -title "Automation" -texts @(
                "1: Copy to Steam Library",
                "0: EXIT"
            )
            $automationOption = Read-Host -Prompt "ENTER"
            if ($automationOption -eq "1") {
                . "C:\Code\PowerShell_Code\ELH_UI\Automation\Copy_to_Steam.ps1"
            }
        }
        2 {
            Menu -title "Control" -texts @(
                "1. Module",
                "2. Path",
                "3. Extract from ZIP",
                "4. Shutdown",
                "5: Restart",
                "6. ShortCut",
                "7. Quit App Force",
                "0: EXIT"
            )
            $controlOption = Read-Host -Prompt "ENTER"
            switch ($controlOption) {
                1 {
                    Menu -title "Module" -texts @(
                        "1: Uninstall Module",
                        "0: EXIT"
                    )
                    $module = Read-Host -prompt "ENTER"
                    switch ($module) {
                        1 { . "C:/Code/POWERSHEL_CODE/ELH_UI/Control/Module/UnInstall_Module.ps1" }
                        0 { }
                        Default {}
                    }
                }
                2 {
                    Menu -title "Path" -texts @(
                        "1: Add to Path",
                        "0: EXIT"
                    )
                    $path = Read-Host -prompt "ENTER"
                    switch ($path) {
                        1 { . "C:\Code\PowerShell_Code\ELH_UI\Control\Path\Add_to_Path1.ps1" }
                        0 { }
                        Default {}
                    }
                }
                3 {
                    . "C:\Code\PowerShell_Code\ELH_UI\Control\Export_from_ZIP.ps1"
                }
                4 {
                    . "C:\Code\PowerShell_Code\ELH_UI\Control\PowerOff.ps1"
                }
                7 {
                    . "C:\Code\PowerShell_Code\ELH_UI\Control\Quit_App_Force.ps1"
                }
                5 {
                    . "C:\Code\PowerShell_Code\ELH_UI\Control\Restart.ps1"
                }
                6 {
                    . "C:\Code\PowerShell_Code\ELH_UI\Control\Shortcut_Create.ps1"
                }
                0 {
                    Menu -texts @("Goodbye!")
                }
                default {
                    Write-Output "Invalid choice. Please try again."
                }
            }
        }
        3 {
            Menu -title "Converter" -texts @(
                "1: HEIC_to_PNG",
                "0: EXIT"
            )
            $conversionOption = Read-Host -Prompt "ENTER"
            if ($conversionOption -eq "1") {
                . "C:\Code\PowerShell_Code\ELH_UI\Converters\HEIC_to_PNG_ConverterMk2.ps1"
            }
        }
        4 {
            Menu -title "Game" -texts @(
                "1: DND game",
                "2: Q&A",
                "0: EXIT"
            )
            $gameOption = Read-Host -Prompt "ENTER"
            switch ($gameOption) {
                1 { . "C:\Code\PowerShell_Code\ELH_UI\Game\DND_Mk4.ps1" }
                2 { . "C:\Code\PowerShell_Code\ELH_UI\Game\Game_Q&A.ps1" }
                0 {  }
                Default {}
            }
        }
        default {
            Write-Output "Invalid choice. Please try again."
        }
    }
} while ($mainOption -ne "0")
