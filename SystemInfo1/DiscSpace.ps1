# Get the directory of the current script
$ScriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Import module using relative path
Import-Module -Name "$ScriptDir\..\ELH_Library.psm1"

# Menu Screen
Menu -title "Disc Space" -texts @("0: EXIT", "ENTER: View Disc Sace")

# Add an Exit button prompt
$exitChoice = Read-Host -Prompt "ENTER"
if ($exitChoice -eq "0") {
    Menu -title "Exiting script..."
    exit
}


# retives avalible disc space and saved under veriable
$diskSpace = Get-PSDrive -PSProvider FileSystem | Select-Object -Property Name, @{
    Name="FreeSpaceGB";Expression={
        [math]::round($_.Free/1GB,2)
    }
}, @{
    Name="UsedSpaceGB";Expression={
        [math]::round(($_.Used/1GB),2)
    }
}, @{
    Name="TotalSpaceGB";Expression={
        [math]::round(($_.Used + $_.Free)/1GB,2)
    }
}    
            
        

# print details 

Menu -title "Available Disk Space:" 

$diskSpace | Format-Table -AutoSize -Property Name, FreeSpaceGB, UsedSpaceGB, TotalSpaceGB


