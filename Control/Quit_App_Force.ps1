# Import module using relative path
Import-Module -Name "$ScriptDir\ELH_Library.psm1"

# Menu Screen
Menu -title "Force Quit App"

# PowerShell script to forcefully close App

$app = Read-Host -prompt "Enter .exe file e.g.(steam.exe)"
taskkill.exe /F /IM $app
