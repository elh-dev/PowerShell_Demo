
#Menu Function 
function Menu {
    param (
        [string[]]$texts # An array of text lines
    )

    $totalWidth = 35
    $topBottomBorder = '_____________________________________'
    $emptyLine = '|                                   |'

    Write-Output $topBottomBorder
    Write-Output $emptyLine

    foreach ($text in $texts) {
        $textLength = $text.Length
        $leftPadding = [math]::Floor(($totalWidth - $textLength) / 2)
        $rightPadding = $totalWidth - $textLength - $leftPadding
        $textLine = '|' + ' ' * $leftPadding + $text + ' ' * $rightPadding + '|'
        Write-Output $textLine
    }

    Write-Output $emptyLine
    Write-Output $topBottomBorder
}


do {
    # Displaying the menu
    Menu -text @("Command Menu")

    # Define the options
    Menu -texts @(
        "1. PowerOff",
        "2. Restart",
        "3. Rename",
        "4. Move Item",
        "5. Add to Path",
        "6. Export from ZIP",
        "7. Installed Modules",
        "8. ShortCutMk2",
        "9. Folder Encryption Attributes",
        "0. Exit"
    )

    # Display the options with a border
    DisplayOptions -options $options

    # User Input
    $choice = Read-Host -Prompt "ENTER"

    # Conditional Execution
    switch ($choice) {
        1 {
            . "C:/Code/PowerShell_Code/comands/PowerOff.ps1"
        }
        2 {
            . "C:/Code/PowerShell_Code/comands/Restart.ps1"
        }
        3 {
            . "C:/Code/PowerShell_Code/Comands/Rename.ps1"
        }
        4 {
            . "C:/Code/PowerShell_Code/Comands/Move_Item.ps1"
        }
        5 {
            . "C:/Code/PowerShell_Code/Comands/Add_to_Path1.ps1"
        }
        6 {
            . "C:/Code/PowerShell_Code/Comands/Export_from_ZIP.ps1"
        }
        7 {
            . "C:/Code/PowerShell_Code/Comands/Installed_Modules.ps1"
        }
        8 {
            . "C:/Code/PowerShell_Code/Comands/ShortCutMk2.ps1"
        }
        9 {
            . "C:/Code/PowerShell_Code/Comands/FolderEncyptionAtributes.ps1"
        }
        0 {
            Menu -text "Goodbye!"
            break
        }
        default {
            Write-Output "Invalid choice. Please try again."
        }

    }
    if ($choice -ge 1) {

        Write-Output "Returning to Menu"   
        Start-Sleep -Seconds 2
    }

} while ($choice -ne 0)
