
# Menu Function
Import-Module -Name "C:\Code\PowerShell_Code\ELH_UI\ELH_Library.psm1"

# Initialize player and enemy data
$Player_1 = @(    
    @(14, 30, 30, 10, 1, 10, 10, "Player", 1),
    @("Weapon", "Armor", "Gold")    
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
function Debug_Module {
    param(
        [Module] $Module,
        [string] $Menu,
        [string] $text
    )
    # Debug
    if ($debug -eq 1) {
        Get-Command -Module $Module -Name $Menu
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
function Dice {
    param (
        $Player_Name,
        $Rolld
    )
    Menu -title "$Player_Name Roll: $Rolld"
}

function Roll {
    param (
        [int] $Rollr,
        [string] $string
    )
    Menu -title "$string $Rollr"
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
        $Rollm20 = Read-Host -Prompt "ENTER Roll"
    } while ($Rollm20 -lt 1 -or $Rollm20 -gt 20)

    return [int]$Rollm20
}
function Manual_Roll_Damage {
    param(
        $Roll_Lower,
        $Roll_Upper
    )
    do {
        # Manual Roll
        $Rollmd = Read-Host -Prompt "ENTER Roll"
    } while ($Rollmd -lt $Roll_Lower -or $Rollmd -gt $Roll_Upper)

    return [int]$Rollmd
}

function Hit_Roll {
    param (
        $option
    )
    # Manual
    if ($option -eq 1) {
        # Manual Roll
        $Rollh = Manual_Roll_D20    
    }
    # Auto
    elseif ($option -eq 0) {
        $Rollh = Get-Random -Minimum 1 -Maximum 20
        Debug -variable $Rollh -text "Player Attack Roll Unaltered"
    }
    return [int]$Rollh
}

# Hit Roll Function 
function Damage_Roll {
    param (
        [array] $Player_1,
        [int] $optiondr 
    )
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
    ELH_Library\Menu -title "Damage Roll" -texts @("1: Manual", "2: Auto")
    $option = $optiondr 
    # Manual
    if ($option -eq 1) {
        do {
            # Manual Roll
            $RollD = Read-Host -Prompt "ENTER Manual Roll"
            Debug -variable $RollD -text "Player Damage Roll ENTERED"
        } while ($RollD -lt $Roll_Lower -or $RollD -gt $Roll_Upper) 
    }
    # Auto
    elseif ($option -eq 2) {
        $RollD = Get-Random -Minimum $Roll_Lower -Maximum $Roll_Upper
        Debug -variable $RollD -text "Player Damage Roll Unaltered"
    }
    # Debug Damage Roll
    Debug -variable $RollD -text 'Player Damage Roll Unaltered'
    
    # Calculate Damage after adding Bonus
    $Damagef = $RollD + $Damage_Bonus
    # Debug Damage Roll
    Debug -variable $Damagef -text 'Player Damage Roll with modifier'
    
    return [int]$Damagef
}

# MAIN
# Calculates Hit Details and Displays to Screen 
function Hit_Screen {
    param(
        [int] $i,
        [array] $Player_1,
        [array] $Enemy_1,
        [int] $optionhs
    )
    $Player_Name = $Player_1[0][7]
    # Debug Player name
    Debug_String -variable $Player_Name -text "debug player name:"
    $option1 = $optionhs

    # Calculate Damage after adding Bonus
    $Damage = Damage_Roll -Player_1 $Player_1 -optiondr $option1
    # Debug Damage
    Debug -variable $Damage.ToString() -text "Damage Roll After Damage Bonus (Hit_Screen)"
    # Roll Display

    Menu -title "$Damage.ToString()"

    # Set enemy HP to variable
    $Enemy_HP = $Enemy_1[$i][0][1]
    # Sets Enemy Name to Variable
    $Enemy_Name = $Enemy_1[$i][0][7]
    # Sets variable to Enemy's new HP
    $Enemy_HP_new = "$Enemy_HP - $Damage"
    # Debug HP
    Debug -variable $Enemy_HP_new -text "Enemy HP after damage calc"

    # Damaged Enemy Info
    if ($Enemy_HP_new -ge 1) {
        # Display Enemy's HP
        Menu -title "$Enemy_Name : $Enemy_HP_new HP"
        return [int]$Enemy_HP_new
    }
    # Kill Enemy
    else {
        # Kill Screen
        Menu -title "Enemy: $Enemy_Name Killed by $Player_Name"
        # Remove enemy from active list (by marking it as dead)
        $Enemy_1[$i][0][8] = 0
        Debug -variable $Enemy_1[$i][0][8] -text "Enemy $Enemy_Name life status:"
    }
}

# Variable for quit function 
$Off = 0
# Variable for Roll Function 
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
                # Option Decide
                $option = Read-Host -Prompt "Enter"
            } while ($option -ne 0 -and $option -ne 1)
            # Roll
            $Roll = Hit_Roll -option $option
            # Debug hit roll
            Debug -variable $Roll -text "Hit Roll BEFORE modifier:"
            # Assign enemy AC to variable 
            $AC = $Enemy_1[$i][0][8]
            # Debug AC
            Debug -variable $AC -text "Enemy AC:"
            # Assign player hit modifier to variable 
            $HitMod = $Player_1[0][5]
            # Debug Hit mod
            Debug -variable $HitMod -text "Player HitMod:"
            # Assigns calculated Final Roll with modifier added 
            $Roll = $Roll + $HitMod
            # Debug hit roll with modifier 
            Debug -variable $Roll -text "Hit Roll AFTER modifier:"
            # Miss Option
            if ($AC -ge $Roll) {
                # Function Displaying miss message
                Menu -title "MISS"
            } 
            # Hit Option
            else {
            Menu -title "HIT"
            Hit_Screen -i $i -Player_1 $Player_1 -Enemy_1 $Enemy_1 -option $option
            }
        } else {
            Menu -title "You have Defeated your Enemies" -texts @("")
            $Off = 0
        }       
    }   
} while ($Off -ne 0)
