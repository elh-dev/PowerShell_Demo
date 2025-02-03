
# HEIC to PNG Converter 

# Menu Function
function Menu {
    param (
        [string]$text,
        [string]$text2 = $null
    )

    $textLength = $text.Length
    $totalWidth = 35
    $leftPadding = [math]::Floor(($totalWidth - $textLength) / 2)
    $rightPadding = $totalWidth - $textLength - $leftPadding

    $topBottomBorder = '_____________________________________'
    $emptyLine = '|                                   |'
    $textLine = '|' + ' ' * $leftPadding + $text + ' ' * $rightPadding + '|'

    $text2Length = if ($text2) { $text2.Length } else { 0 }
    $leftPadding2 = if ($text2) { [math]::Floor(($totalWidth - $text2Length) / 2) } else { 0 }
    $rightPadding2 = if ($text2) { $totalWidth - $text2Length - $leftPadding2 } else { 0 }
    $textLine2 = if ($text2) { '|' + ' ' * $leftPadding2 + $text2 + ' ' * $rightPadding2 + '|' } else { $null }

    Write-Output $topBottomBorder
    Write-Output $emptyLine
    Write-Output $textLine
    if ($text2) {
        Write-Output $textLine2
    }
    Write-Output $emptyLine
    Write-Output $topBottomBorder
}

# Menu
Menu -text "HEIC to PNG"

# Assigns path to veriables 
$inputFile = Read-Host  "Path To HEIC File"  # Replace with your HEIC file path
$outputFile = Read-Host "Pathe To PNG"  # Replace with your desired PNG file path

# Load Windows built-in Imaging Component (WIC) to decode and encode images
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Load HEIC image
$heicImage = [System.Drawing.Image]::FromFile($inputFile)

# Save image as PNG
$heicImage.Save($outputFile, [System.Drawing.Imaging.ImageFormat]::Png)

# Dispose of the HEIC image to free resources
$heicImage.Dispose()
