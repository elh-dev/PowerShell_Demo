# Get the directory of the current script
$ScriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Import module using relative path
Import-Module -Name "$ScriptDir\..\ELH_Library.psm1"


# Menu Screen
Menu -title "Up Time" -texts @("0: EXIT", "ENTER: Up Time")

# Add an Exit button prompt
$exitChoice = Read-Host -Prompt "ENTER"
if ($exitChoice -eq "0") {
    Menu -title "Exiting script..."
    exit
}

# retives the system up time and save under veriable
$uptime = (Get-CimInstance Win32_operatingSystem).LastBootUpTime
     

# print details 
Menu -title "System Uptime: $([DateTime]::Now - $uptime)" 

