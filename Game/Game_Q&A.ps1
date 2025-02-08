# Get the directory of the current script
$ScriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Import module using relative path
Import-Module -Name "$ScriptDir\..\ELH_Library.psm1"

# Menu Screen
Menu -title "Question & Answer Game" -texts @("0: EXIT", "ENTER: View Disc Sace")

# Add an Exit button prompt
$exitChoice = Read-Host -Prompt "ENTER"
if ($exitChoice -eq "0") {
    Menu -title "Exiting script..."
    exit
}
# Define the questions and answers
$questions = @{
    "What is my name" = @("Ed", "elh-dev")
    "Are dragons cool" = @("yes", "stupid question")
    
}

# Initialize score
$score = 0

# Loop through each question
foreach ($question in $questions.Keys) {
    # Ask the question and get the user's answer
    Menu -title "$question"
    $userAnswer = Read-Host -Prompt "Enter"

    # Check if the answer is correct
    if ($questions[$question] -icontains $userAnswer) {
        Menu -title "Correct!"
        $score++
    } else {
        Menu -title "Incorrect." @("The correct answer is:", "$($questions[$question] -join ', ')")
        # Prompt the user for confirmation before shutting down 
    }
}

# Display the final score
Menu -title "Game over! Your final score is $($score/$($questions.Count)*100)%.", "Good Job."
