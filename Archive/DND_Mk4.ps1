# Menu Function
Import-Module -Name "C:\Code\PowerShell_Code\ELH_UI\ELH_Library.psm1"

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
    @("Weapon", "Armor", "Gold") # equipment
    
)
$Enemy_1 = @(
    @(
        @(10, 30, 30, 10, 1, 3, 3, "1", 1),
        @("Weapon", "Armor", "Gold")
    ),
    @(
        @(10, 30, 30, 10, 1, 3, 3, "2", 1),
        @("Weapon", "Armor", "Gold")
    ),
    @(
        @(10, 30, 30, 10, 1, 3, 3, "3", 1),
        @("Weapon", "Armor", "Gold")
    ),
    @(
        @(10, 30, 30, 10, 1, 3, 3, "4", 1),
        @("Weapon", "Armor", "Gold")
    )
)

function Debug {
    param(
        [int]$veriable,
        [string] $text
    )
    #debug
    if ($debug -eq 1) {
        Write-Host $text ": " $veriable
    }
}
function Debug_Module {
    param(
        [Module] $Module,
        [string] $Menu,
        [string] $text
    )
    #debug
    if ($debug -eq 1) {
        Get-Command -Module $Module -Name $Menu

    }
}
function Debug_String {
    param(
        [string]$veriable,
        [string] $text
    )
    #debug
    if ($debug -eq 1) {
        Write-Host $text ": " $veriable
    }
}
function Dice {
    param (
        $Player_Name,
        $Roll
    )
    Menu -title "$Player_Name Roll: $Roll"
    
}

function Roll {
    param (
        [int] $Roll,
        [string] $string
    )

    Menu -title "$string $Roll"
    
}
# Returns Debug Option 
function Debug_Option {
    # Veriable for Debug Funtion 
    $debug = 0

    # Debug Menu and select  
    $debug = Read-Host -Prompt '1 for debug 0 for standard'

    # Loop until the user selects either 0 or 1
    while ($debug -ne 0 -and $debug -ne 1) {
        # Prompt the user for input
        $debug = Read-Host -Prompt "Please enter 0 or 1"
        
        # Check if the input is valid (0 or 1)
        if ($debug -ne 0 -and $debug -ne 1) {
            Write-Output "Invalid selection. Please enter 0 or 1."
        }
    }
    return [int]$debug
}
function Manual_Roll_D20 {
    do {

        # Manual Roll
        $Roll = Read-Host -Prompt "ENTER Roll"

    } while ($Roll -lt 1 -or $Roll -gt 20)

    return [int]$Roll
}

function Hit_Roll {
    param (
        $option
    )
    # Manual
    if ($option -eq 1) {

        # Manual Roll
        $Roll = Manual_Roll_D20    
    }

    # Auto
    elseif ($option -eq 0) {

        $Roll = Get-Random -Minimum 1 -Maximum 20

        Debug -veriable $Roll -text "Player Attack Roll Unaltered"
    }

    return [int]$Roll
}

# Hit Roll Funtion 
function Damage_Roll {
    param (
        [array] $Player_1,
        [int] $option 
    )
    # Sets Players Lower Dice Range to variables 
    $Roll_Lower = $Player_1[0][4]
        
    # Debug Upper And Lower Dice Range 
    Debug -variable $Roll_Lower -text "Roll Lower Limit"
    
    $Roll_Upper = $Player_1[0][3]
    # Debug Upper Dice Range 
    Debug -variable $Roll_Upper -text "Roll Upper Limit"
                
    
    #Sets Variable to Players Damage Bonus 
    $Damage_Bonus = $Player_1[0][6]
    
    # Debug Damage Modifier 
    Debug -variable $Damage_Bonus -text "Player Damage Modifier"
                   
    # Debug Upper And Lower Dice Range 
    Debug -variable $Roll_Lower -text "Roll Lower Limit"
       
    # Damage Calculations ROLL using player's dice range
    ELH_Library\Menu -title "Damage Roll" -texts @("1: Manual", "2: Auto")
    
    # Manual
    if ($option -eq 1) {
    
        # Manual Roll
    do {
    
        # Manual Roll
        $Roll = Read-Host -Prompt "ENTER Manual Roll"
        Debug -variable $Roll -text "Player Damage Roll ENTERED"
        
    } while  ($Roll -lt $Roll_Lower -or $Roll -gt $Roll_Upper) 
            
    }
    
    # Auto
    elseif ($option -eq 2) {
    
        $Roll = Get-Random -Minimum $Roll_Lower -Maximum $Roll_Upper
    
        Debug -variable $Roll -text "Player Damage Roll Unaltered"
    }

    # Debug Damage Roll
    Debug -variable $Roll -text 'Player Damage Roll Unaltered'
        
       
    
    # Calculate Damage after adding Bonus
    $Damage = $Roll + $Damage_Bonus
    
    # Debug Damage Roll
    Debug -variable $Damage -text 'Player Damage Roll with modifier'
    
    return [int]$Damage
}
    
# MAIN
# Calculates Hit Details and Displays to Screen 
function Hit_Screen {
    param(
        [int]$i,
        [array]$Player_1,
        [array]$Enemy_1

    )
    $Player_Name = $Player_1[0][7]

    # Debug Player name
    Debug_String -veriable $Player_Name -text "debug player name:"
    
    # Calculate Damage after adding Bonus
    $Damage = Damage_Roll -Player_1 $Player_1
            
    # Debug Damage
    Debug -veriable $Damage -text "Damage Roll After Damage Bonus (Hit_Screen)"
            
    # Roll Display
    Menu -title $Damage

    # Set enemy HP to variable
    $Enemy_HP = $Enemy_1[$i][0][1]

    # Sets Enemy Name to Variable
    $Enemy_Name = $Enemy_1[$i][0][7]

    # Sets variable to Enemy's new HP
    $Enemy_HP_new = $Enemy_HP - $Damage

    # debug HP
    Debug -veriable $Enemy_HP_nem -text "Enemy HP after damage calc"

    # Damaged Enemy Info
    if ($Enemy_HP1 -ge 1) {

        # Display Enemy's HP
        Menu -title "$Enemy_Name : $Enemy_HP_new HP"

        # Reduce Enemy's Saved HP
        
        return [int]$Enemy_HP_new
    }

    # Kill Enemy
    else {


        #Kill Screen
        Menu -title "Enemy: $Enemy_Name Killed by $Player_Name"
                
        # Remove enemy from active list (by marking it as dead
        $Enemy_1[$i][0][8] = 0

        Debug -veriable $Enemy_1[$i][0][8] -text "Enemy $Enemy_Name life status:"
                
    }
}


# Veriable for quite funtion 
$Off = 0

# Veriable for Roll Funtion 
$Roll = -1

$debug = Debug_Option
# Exit 
$Exit_Game1 = 0

# Loop to repeat game
do {

    # Loop for combat round
    for ($i = 0; $i -lt $Enemy_1.Count -and $Exit_Game1 -ne 1; $i++) {

        # Ensure the next loop iteration skips null or dead enemies
        if ($Enemy_1[$i][0][8] -ne 0) {
                    
            # Menu Manual or Auto
            do {
                
                Menu -title "Hit Roll" -texts @("1: Manual", "0: Auto")
                # Option Decid
                $option = Read-Host -Prompt "Enter"

            } while ($option -ne 0 -and $option -ne 1)

            # Roll
            $Roll = Hit_Roll -option $option

            #debug hit roll
            Debug -veriable $Roll -text "Hit Roll BEFORE modifier:"
            # Assign enemy ac to veriabel 
            $AC = $Enemy_1[$i][0][8] 
            # debug AC
            Debug -veriable $AC -text "Enemy AC:"
            # Assign palyer hit modifer to veriabel 
            $HitMod = $Player_1[0][5]
            # debug Hit mod
            Debug -veriable $HitMod -text "Player HitMod:"
            # assigns calculated Final Roll with modifer added 
            $Roll = $Roll + $HitMod
            # debug hit roll with modifer 
            Debug -veriable $Roll -text "Hit Roll AFTER modifier:"
            # Miss Option
            if ( $AC -ge $Roll) {

                # Function Displaying miss message
                Menu -title "MISS"
            } 
            # Hit Option
            else {

                Menu -title "HIT"
                Hit_Screen -i $i -Player_1 $Player_1 -Enemy_1 $Enemy_1
            }
        
        }
        else{
            Menu -title "You have Defeated your Enemys" -texts @("")
            $off = 0
               
        }
    }   
    
} while ($Off -ne 0)
