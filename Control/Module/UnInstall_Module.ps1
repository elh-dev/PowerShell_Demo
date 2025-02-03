# Import module using relative path
Import-Module -Name "$ScriptDir\ELH_Library.psm1"

Menu -title "Uninstall Module"

# Assigns moduel name and version to veriables 
$Module = Read-Host -Prompt 'Enter Module Name'
$Version = Read-Host -Prompt 'Enter Version'

# Uninstalls the module specific to the version 
Uninstall-Module -Name $Module -RequiredVersion $Version

# Allows you to confirm if module is still present
Get-Module -Name $Module -ListAvailable

