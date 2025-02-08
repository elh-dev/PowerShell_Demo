# Define parameters for script paths
param (
    [string]$CopyToSteamPath,
    [string]$UninstallModulePath,
    [string]$AddToPathPath,
    [string]$ExportFromZIPPath,
    [string]$PowerOffPath,
    [string]$QuitAppForcePath,
    [string]$RestartPath,
    [string]$ShortcutCreatePath,
    [string]$HEICtoPNGPath,
    [string]$DNDGamePath,
    [string]$GameQAPath,
    [string]$DiscSpacePath,
    [string]$UpTimePath,
    [string]$OSVersionPath
)

# Get the directory of the current script
$ScriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Assign default values to parameters if not provided
if (-not $CopyToSteamPath) { $CopyToSteamPath = "$ScriptDir\Automation\Copy_to_Steam.ps1" }
if (-not $UninstallModulePath) { $UninstallModulePath = "$ScriptDir\Control\Module\UnInstall_Module.ps1" }
if (-not $AddToPathPath) { $AddToPathPath = "$ScriptDir\Control\Path\Add_to_Path1.ps1" }
if (-not $ExportFromZIPPath) { $ExportFromZIPPath = "$ScriptDir\Control\Export_from_ZIP.ps1" }
if (-not $PowerOffPath) { $PowerOffPath = "$ScriptDir\Control\PowerOff.ps1" }
if (-not $QuitAppForcePath) { $QuitAppForcePath = "$ScriptDir\Control\Quit_App_Force.ps1" }
if (-not $RestartPath) { $RestartPath = "$ScriptDir\Control\Restart.ps1" }
if (-not $ShortcutCreatePath) { $ShortcutCreatePath = "$ScriptDir\Control\Shortcut_Create.ps1" }
if (-not $HEICtoPNGPath) { $HEICtoPNGPath = "$ScriptDir\Converters\HEIC_to_PNG_ConverterMk2.ps1" }
if (-not $DNDGamePath) { $DNDGamePath = "$ScriptDir\Game\DND_Mk1.ps1" }
if (-not $GameQAPath) { $GameQAPath = "$ScriptDir\Game\Game_Q&A.ps1" }

if (-not $DiscSpacePath) { $DiscSpacePath = "$ScriptDir\SystemInfo1\DiscSpace.ps1" }
if (-not $UpTimePath) { $UpTimePath = "$ScriptDir\SystemInfo1\UpTime.ps1" }
if (-not $OSVersionPath) { $OSVersionPath = "$ScriptDir\SystemInfo1\OSVersion.ps1" }
if (-not $InstalledSoftwearPath) { $InstalledSoftwearPath = "$ScriptDir\SystemInfo1\InstalledSoftwear.ps1" }

# Import module using relative path
Import-Module -Name "$ScriptDir\ELH_Library.psm1"

do {
    # Displaying the menu
    Menu -title "Command Menu" -texts @(
        "1: Automation",
        "2: Control",
        "3: Conversion",
        "4: Game",
        "5: System Info",
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
                . $CopyToSteamPath
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
                        1 { . $UninstallModulePath }
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
                        1 { . $AddToPathPath }
                        0 { }
                        Default {}
                    }
                }
                3 {
                    . $ExportFromZIPPath
                }
                4 {
                    . $PowerOffPath
                }
                7 {
                    . $QuitAppForcePath
                }
                5 {
                    . $RestartPath
                }
                6 {
                    . $ShortcutCreatePath
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
                . $HEICtoPNGPath
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
                1 { . $DNDGamePath }
                2 { . $GameQAPath }
                0 {  }
                Default {}
            }
        }
        5 {
            Menu -title "System Info" -texts @(
                "1: Disc Space",
                "2: Up Time",
                "3: OS Version",
                "4: Installed Softwear"
                "0: EXIT"
            )
            $SystemInfoOption = Read-Host -Prompt "ENTER"
            switch ($SystemInfoOption) {
                1 { . $DiscSpacePath}
                2 { . $UpTimePath}
                3 { . $OSVersionPath}
                4 { . $InstalledSoftwearPath}
                0 {  }
                Default {}
            }
        }
        default {
            Write-Output "Invalid choice. Please try again."
        }
    }
} while ($mainOption -ne "0")
