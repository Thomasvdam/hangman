# Hangman

An iOS implementation of the popular word-guessing game Hangman.

## Features

* New game  
  Start a new game where the game selects a random word of length N, which is described in the settings, and where the user is allowed X wrong guesses, which is also described in the settings. Gameplay proceeds in a regular manner, where the user chooses a letter to guess and the game displays the letter in all the positions in which it occurs, or if the word does not contain the letter, the game notifies the user that the guess was incorrect and updates the remaining number of wrong guesses the user has.

* Continue game  
  A game is started, but instead of beginning anew the game will continue from a previous state.

* Highscores  
  Based on how well the user plays the game he or she is rewarded with a score at the end of a successful game. The top 10 scores are stored internally and can be viewed at the users discretion.

* Settings  
  Here the user can indicate the length of the word to be guessed and the amount of wrong guesses that he or she can make. This will affect scoring in some way.

## Technologies

Since it is an iOS version the main language in which the application will be written is Objective-C. 

### Frameworks

* CoreGraphics.framework
* UIKit.framework
* Foundation.framework
* SQLite DB .lldb