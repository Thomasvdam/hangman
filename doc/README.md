# Hangman Design Document

Technical details of the iOS application Hangman.

## Word List

I intend to parse the words.plist file and add the contents to a sqlite database to (hopefully) make it easier and faster to find words of a certain length, especially if I get to implementing evil hangman.

## Models

* Gameplay model  
    A model for the actual gameplay that has at least 2 different initialiser methods. One to start a completely new game and one that takes several arguments which together make up the state of the game as it was when the application was terminated.
    
* Highscores model
    A model that handles the storing and retrieving of highscores.
    
## Views

* Main view  
    Here is where most of the action takes place. This view will display the word the player is attempting to guess, the amount of mistakes remaining, and the current score.

* Flipside view  
    This view displays the values of the settings for the length of the word to be guessed, the amount of mistakes that can be made, the score modiefier based on these two settings, and a button that displays the highscore view.

* Highscore view  
    This view displays the top 10 (if available) highscores and the names associated with them. Possibly add a button that allows the user to reset the highscores?