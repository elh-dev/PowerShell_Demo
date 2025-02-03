# Import module using relative path
Import-Module -Name "$ScriptDir\ELH_Library.psm1"

Menu -title "Create Shortcut" -texts @("1: File", "2: Folder", "0: Quit")
$option = Read-Host -Prompt 'Enter'

# Directory or Application Gate
if ($option -eq 1) {
    # Defines the path for the shortcut and name of shortcut.lnk or .url
    $shortcutPath = Read-Host -Prompt 'Enter full path of desired shortcut location e.g., (C:\Users\edwar\OneDrive\Desktop\Shortcut.lnk)'


    $WorkingDir = Read-Host -Prompt "Enter the working directory e.g., (C:\Program Files\Oracle\VirtualBox)"

    # Defines the target Application
    $targetPath = Read-Host -Prompt 'Enter full path of desired File e.g., ("C:\Program Files\Oracle\VirtualBox\VirtualBox.exe")'

}
elseif ($option -eq 2) {
    # Defines the path for the shortcut and name of shortcut.lnk or .url
    $shortcutPath = Read-Host -Prompt 'Enter full path of desired shortcut location e.g., (C:\Users\edwar\OneDrive\Desktop\Shortcut.lnk)'

    # Defines the target Directory
    $targetPath = Read-Host -Prompt 'Enter full path of desired Folder e.g., (C:\Code)' 
}
elseif ($option -eq 0) {
    return
}


# Create a COM object for WScript Shell used to execute applications
$WScriptShell = New-Object -ComObject WScript.Shell

# Create the shortcut
$shortcut = $WScriptShell.CreateShortcut($shortcutPath)

# Set the shortcut properties
$shortcut.TargetPath = $targetPath

# Directory or Application Gate
if ($option -eq 2) {

    # Defines Working Directory as the Directory previously stated 
    $WorkingDir = $targetPath
}

$shortcut.WorkingDirectory = $WorkingDir

$shortcut.WindowStyle = 1
$shortcut.IconLocation = "$targetPath, 0"
$shortcut.Save()

Menu -title "Shortcut created successfully at $shortcutPath"
