# Get the directory of the current script
$ScriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Import module using relative path
Import-Module -Name "$ScriptDir\..\ELH_Library.psm1"

# Menu Screen
Menu -title "DND Game" -texts @("0: EXIT", "ENTER: View Disc Sace")

# Add an Exit button prompt
$exitChoice = Read-Host -Prompt "ENTER"
if ($exitChoice -eq "0") {
    Menu -title "Exiting script..."
    exit
}
# Initialize player and enemy data
$Player_1 = @(
    
    @(
        14, # Armor Rating
        30, # Health Current
        30, # Health Upper
        10, # Upper Hit
        1,  # Lower Hit
        10, # Attack Bonus
        10, # Damage Bonus
        "Player", # NAME
        1   # Life status 1 for alive 0 for dead
    ),
    @(@("Weapon", "Armor", "Gold"),
    @("", "", ""),
    @("", "", ""),
    @("", "", ""),
    @("", "", "")
    ) # equipment
    
)
$Enemy_1 = @(
    @(@(10, 30, 30, 10, 1, 3, 3, "1", 1), @("Weapon", "Armor", "Gold")),
    @(@(10, 30, 30, 10, 1, 3, 3, "2", 1), @("Weapon", "Armor", "Gold")),
    @(@(10, 30, 30, 10, 1, 3, 3, "3", 1), @("Weapon", "Armor", "Gold")),
    @(@(10, 30, 30, 10, 1, 3, 3, "4", 1), @("Weapon", "Armor", "Gold"))
)


function Debug {
    param(
        [int]$variable,
        [string] $text
    )
    # Debug
    if ($debug -eq 1) {
        Write-Host "$text " -NoNewline
        Write-Host ": $variable"
    }
}
function Debug_String {
    param(
        [string]$variable,
        [string] $text
    )
    # Debug
    if ($debug -eq 1) {
        Write-Host "$text " -NoNewline
        Write-Host ": $variable"
    }
}

# Returns Debug Option 
function Debug_Option {
    # Variable for Debug Function 
    $debug = 0

    # Debug Menu and select  
    $debug = Read-Host -Prompt '1 for debug 0 for standard'

    # Loop until the user selects either 0 or 1
    while ($debug -ne 0 -and $debug -ne 1) {
        # Prompt the user for input
        $debug = Read-Host -Prompt "ENTER"
        
        # Check if the input is valid (0 or 1)
        if ($debug -ne 0 -and $debug -ne 1) {
            Menu -title "Invalid selection. Please enter 0 or 1."
        }
    }
    return [int]$debug
}
function Manual_Roll_D20 {
    Menu -title "Roll D20"
    do {
        # Manual Roll
        $Roll20 = Read-Host -Prompt "ENTER"

    } while ($Roll20 -lt 1 -or $Roll20 -gt 20)
    $Manual_Roll = $Roll20.ToString()
    Menu -title "$Manual_Roll"

    return [int]$Roll20
}
function Manual_Roll_Damage {
    param(
        [array] $Player_1
    )
    Menu -title "Manual Roll"
    do {
        # Manual Roll
        $RollDD = Read-Host -Prompt "ENTER"
    } while ($RollDD -lt $Player_1[0][4] -or $RollDD -gt $Player_1[0][4])

    return [int]$RollDD
}


# Hit Roll Function 
# MAIN
# Calculates Hit Details and Displays to Screen 




$debug = Debug_Option

# Loop to repeat game
do {
    # Veriable for inventory slots
    $y = 1
    # Loop for combat round
    for ($i = 0; $i -lt $Enemy_1.Count; $i++) {

        # Ensure the next loop iteration skips dead enemies with a 0 life 
        if ($Enemy_1[$i][0][8] -ne 0) {

            # Menu Manual or Auto
            do {
                Menu -title "Hit Roll" -texts @("1: Manual", "0: Auto")

                # Option Decide
                $HitRollOption = Read-Host -Prompt "Enter"
            # Loop for options
            } while ($HitRollOption -ne 0 -and $HitRollOption -ne 1)

            # Manual
            if ($HitRollOption -eq 1) {
                # Manual Roll Function
                $HitRoll = Manual_Roll_D20    
            }

            # Auto
            elseif ($HitRollOption -eq 0) {

                # Auto roll 
                $HitRoll = Get-Random -Minimum 1 -Maximum 20
                Debug -variable $HitRoll -text "Player Attack Roll before modefier"
            }

        
            # Assign enemy AC to variable 
            $EnemyAC = $Enemy_1[$i][0][8]
            Debug -variable $EnemyAC -text "Enemy AC:"

            # Assign player hit modifier to variable 
            $HitMod = $Player_1[0][5]
            Debug -variable $HitMod -text "Player HitMod:"

            # Assigns calculated Final Roll with modifier added 
            $FinalHitRoll = $HitRoll + $HitMod
            Debug -variable $FinalHitRoll -text "Hit Roll AFTER modifier:"

            # Miss 
            if ($EnemyAC -ge $FinalHitRoll) {
                # Function Displaying miss message
                Menu -title "MISS"
            } 
            # Hit 
            else {
            Menu -title "HIT"

            # Player Name Veriable 
            $Player_Name = $Player_1[0][7]
            Debug_String -variable $Player_Name -text "debug player name:"

            # Calculate Damage after adding Bonus
            # Sets Players Lower Dice Range to variables 
            $Roll_Lower = $Player_1[0][4]
            # Debug Upper And Lower Dice Range 
            Debug -variable $Roll_Lower -text "Roll Lower Limit"
            
            $Roll_Upper = $Player_1[0][3]
            # Debug Upper Dice Range 
            Debug -variable $Roll_Upper -text "Roll Upper Limit"
            
            # Sets Variable to Players Damage Bonus 
            $Damage_Bonus = $Player_1[0][6]
            # Debug Damage Modifier 
            Debug -variable $Damage_Bonus -text "Player Damage Modifier"
            
            # Damage Calculations ROLL using player's dice range
            ELH_Library\Menu -title "Damage Roll" -texts @("1: Manual", "0: Auto")

            $DamageRollOption = Read-Host -prompt "ENTER"

            # Manual
            if ($DamageRollOption -eq 1) {
                Menu -title "Manual Roll"
                do {
                    # Manual Roll
                    
                    $DamageRoll = Read-Host -Prompt "ENTER"
                    
                } while ($DamageRoll -lt $Player_1[0][4] -or $DamageRoll -gt $Player_1[0][3])
                Debug -variable $DamageRoll -text "Player Manual Damage Roll Unaltered" 
            }
            # Auto
            elseif ($DamageRollOption -eq 0) {
                $DamageRoll = Get-Random -Minimum $Player_1[0][4] -Maximum $Player_1[0][3]
                Debug -variable $DamageRoll -text "Player Auto Damage Roll Unaltered"
            }
            
            # Calculate Damage after adding Bonus
            $FinalDamage = $DamageRoll + $Damage_Bonus
            # Debug Damage Roll
            Debug -variable $FinalDamage -text 'Player Damage Roll with modifier'

            $Damage = $FinalDamage

            Debug -variable $Damage -text "Damage Roll After Damage Bonus (Hit_Screen)"

            # Roll Display
            $DamageString = $Damage.ToString()
            Menu -title "$DamageString"

            # Set enemy HP to variable
            $Enemy_HP = $Enemy_1[$i][0][1]
            Debug -variable $Enemy_HP -text "Enemy HP:"

            # Sets Enemy Name to Variable
            $Enemy_Name = $Enemy_1[$i][0][7]
            Debug_String -variable $Enemy_Name -text "Enemy Name:"

            # Sets variable to Enemy's new HP
            $Enemy_HP_new = $Enemy_HP - $Damage
            $Enemy_1[$i][0][1] = $Enemy_HP_new
            $Enemy_HP_int = $Enemy_1[$i][0][1]
            Debug -variable $Enemy_HP_int -text "Enemy HP after damage calc applied"
            
            Debug -variable $Enemy_HP_new -text "Enemy HP after damage calc unaplied"

            # Damaged Enemy Info
            if ($Enemy_HP_new -ge 1) {
                # Display Enemy's HP
                $EnemyHPString = $Enemy_HP_new.ToString()
                Menu -title "$Enemy_Name : $EnemyHPString HP"
            }

            # Kill Enemy
            else {
                # Kill Screen
                Menu -title "Enemy: $Enemy_Name Killed by $Player_Name"
               
                # Remove enemy from active list (by marking it as dead)
                $Enemy_1[$i][0][8] = 0

                Debug -variable $Enemy_1[$i][0][8] -text "Enemy life status:"
                
                $Player_1[1][$y] = $Enemy_1[$i][1]
                $y++
                Menu -title "Enemys Dead"

                $totalWidth = 50
    
                # The top and bottom border line
                $topBottomBorder = "_" * $totalWidth
                
                # An empty line inside the menu
                $emptyLine = '|' + ' ' * ($totalWidth - 2) + '|'
                $titleLength = $title.Length
                $leftPadding = [math]::Floor(($totalWidth - $titleLength - 2) / 2)
                $rightPadding = $totalWidth - $titleLength - 2 - $leftPadding
                    
                # Output the top border of the menu
               
                
                # Output an empty line
                Write-Output $emptyLine
                for ($i = 0; $i -lt $Enemy_1.Count; $i++) {
                    if ($Enemy_1[$i][0][8] -eq 0) {
                        $string =  $Enemy_1[$i][0][7]
                        $stringLine = '|' + ' ' * $leftPadding + $string + ' ' * $rightPadding + '|'
                    
                        Write-Output $stringLine 
                    }
            
                }
                Write-Output $emptyLine
                Write-Output $topBottomBorder
            
            }

            }
        } else {
            Menu -title "You have Defeated your Enemies" -texts @("")
            $Off = 0
        }       
    }   
} while ($Off -ne 0)
