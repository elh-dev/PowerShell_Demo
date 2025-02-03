# Import module using relative path
Import-Module -Name "$ScriptDir\ELH_Library.psm1"


 # Loop for menu
do {
    
   
        # Title Menu
        Menu -title  "Add to Path" -texts @("1: Add to Path", "0: Exit")

        # Check if running as administrator
        if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
            Menu -title "Please run PowerShell as Administrator"
            exit
        }

        # Assigns module name and version to variables
        $Module = Read-Host -Prompt 'Module Name (PS2EXE)'

        # Finds Module Path
        $module = Get-Module -Name $Module -ListAvailable

        if ($module) {
            $modulePath = $module.ModuleBase

            # Adds Path to Environment Variable
            [Environment]::SetEnvironmentVariable("PATH", $env:PATH + ";$modulePath", [EnvironmentVariableTarget]::Machine)

            # Verify the PATH
            $newPath = $env:PATH

            Menu -title "Module Path Added Successfully"

            # Display the new PATH
            Write-Output "New PATH: $newPath"

        } else {
            Menu -title "Module Not Found"
        }
        

} while (
    $option -ne "0"    
)