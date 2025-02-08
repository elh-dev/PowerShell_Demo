# MenuModule.psm1

# Prints vissualy pleasing menu and options
function Menu {
    param (
        # The title of the menu
        [string]$title,
        
        # An array of text lines to display in the menu
        [string[]]$texts = @()
    )

    # Total width of the menu (including borders)
    $totalWidth = 50
    
    # The top and bottom border line
    $topBottomBorder = "_" * $totalWidth
    
    # An empty line inside the menu
    $emptyLine = '|' + ' ' * ($totalWidth - 2) + '|'

    # Output the top border of the menu
    Write-Output $topBottomBorder
    
    # Output an empty line
    Write-Output $emptyLine

    # Calculate the padding for the title to center it
    $titleLength = $title.Length
    $leftPadding = [math]::Floor(($totalWidth - $titleLength - 2) / 2)
    $rightPadding = $totalWidth - $titleLength - 2 - $leftPadding
    $titleLine = '|' + ' ' * $leftPadding + $title + ' ' * $rightPadding + '|'
    
    # Output the title line
    Write-Output $titleLine

    # Output another empty line
    Write-Output $emptyLine
    
    # Output the bottom border of the title section
    Write-Output $topBottomBorder

    # Check if there are any text lines to display
    if ($texts.Length -gt 0) {
        # Output an empty line before the text lines
        Write-Output $emptyLine
        
        # Loop through each text line
        foreach ($text in $texts) {
            # Calculate the padding for each text line to center it
            $textLength = $text.Length
            $leftPadding = [math]::Floor(($totalWidth - $textLength - 2) / 2)
            $rightPadding = $totalWidth - $textLength - 2 - $leftPadding
            $textLine = '|' + ' ' * $leftPadding + $text + ' ' * $rightPadding + '|'
            
            # Output the text line
            Write-Output $textLine
        }
        
        # Output an empty line after the text lines
        Write-Output $emptyLine
        
        # Output the bottom border of the menu
        Write-Output $topBottomBorder
    }
}


# Example usage:
# Menu -title "Menu Title" -texts @("Option 1", "Option 2", "Option 3")
# Menu -title "Menu Title"

function Get-FileHashMap {
    param (
        [string]$directoryPath
    )

    $hashMap = @{}
    $files = Get-ChildItem -Path $directoryPath -Recurse -File

    foreach ($file in $files) {
        $hash = Get-FileHash -Path $file.FullName -Algorithm SHA256
        $relativePath = $file.FullName.Substring($directoryPath.Length)
        $hashMap[$relativePath] = @{
            Hash = $hash.Hash
            Size = $file.Length
        }
    }

    return $hashMap
}



