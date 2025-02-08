# Get the directory of the current script
$ScriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Import module using relative path
Import-Module -Name "$ScriptDir\..\ELH_Library.psm1"

# Menu Screen
Menu -title "Copy to Steam" -texts @("0: EXIT", "ENTER: View Disc Sace")

# Add an Exit button prompt
$exitChoice = Read-Host -Prompt "ENTER"
if ($exitChoice -eq "0") {
    Menu -title "Exiting script..."
    exit
}

# Define the directory to monitor
$sourceDirectory = Read-Host -prompt "Enter Source Path (D:\Games\Helldivers 2)"

# Define the destination directory
$destinationDirectory = "C:\Program Files (x86)\Steam\steamapps\common"

# Perform the copy operation
Copy-Item -Path $sourceDirectory -Destination $destinationDirectory -Force -Recurse

# Verify integrity by comparing hash values and file sizes
$sourceHashMap = Get-FileHashMap -directoryPath $sourceDirectory
$destinationHashMap = Get-FileHashMap -directoryPath $destinationDirectory

$allMatch = $true
Menu -texts @("Hashing Data for Integrity Check")
foreach ($key in $sourceHashMap.Keys) {
    if ($destinationHashMap.ContainsKey($key)) {
        if ($sourceHashMap[$key].Hash -ne $destinationHashMap[$key].Hash) {
            $allMatch = $false
            Write-Output "Hash mismatch detected: $key"
        } elseif ($sourceHashMap[$key].Size -ne $destinationHashMap[$key].Size) {
            $allMatch = $false
            Write-Output "Size mismatch detected: $key"
        }
    } else {
        $allMatch = $false
        Write-Output "File missing in destination: $key"
    }
}

if ($allMatch) {
    $text = "Integrity check passed. All files match."
} else {
    $text = "Integrity check failed. Some files do not match."
}

Menu -texts @($text)

# Add an Exit button prompt
$exitChoice = Read-Host -Prompt "Type 'exit' to close the script or press Enter to continue"
if ($exitChoice -eq "exit") {
    Write-Output "Exiting script..."
    exit
}
