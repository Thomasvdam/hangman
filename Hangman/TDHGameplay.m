//
//  TDHGameplay.m
//  Hangman
//
//  Created by Thomas van Dam on 13/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import "TDHGameplay.h"
#import "TDHWordPicker.h"

@interface TDHGameplay ()

@property (readwrite) NSString *display;
@property (readwrite) NSString *pickedWord;
@property (readwrite) int mistakes;
@property (readwrite) NSMutableSet *unusedLetters;
@property NSMutableSet *unusedLettersInWord;
@property (readwrite) int score;

@end

@implementation TDHGameplay

/*****
 * Create an instance of the gameplay class based on the specifications passed.
 *****/
+ (id)newGameWithWordLength:(int)wordLength mistakes:(int)mistakes {
    return [[self alloc] initWithWordLength:wordLength mistakes:mistakes];
}

- (id)initWithWordLength:(int)wordLength mistakes:(int)mistakes {
    self = [super init];
    
    if (self) {
        TDHWordPicker *wordPicker = [[TDHWordPicker alloc] init];
        self.pickedWord = [wordPicker pickWordWith:wordLength];
        self.mistakes = mistakes;
        self.unusedLetters = [self initiateUnusedLetters];
        self.unusedLettersInWord = [self initiateunusedLettersInWord:self.pickedWord];
        self.score = 1; // TODO!
        self.display = [self maskWord:self.pickedWord withSet:self.unusedLettersInWord];
    }
    return self;
}

/*****
 * TODO.
 *****/
+ (id)resumeGameWithWord:(NSString *)word unusedLetters:(NSMutableSet *)unusedLetters mistakesRemaining:(int)mistakes score:(int)score{
    return [[self alloc] init];
}

+ (id)newTestGame {
    return [[self alloc] initForTest];
}

- (id)initForTest {
    self = [super init];
    if (self) {
        self.pickedWord = @"DUCK";
        self.mistakes = 4;
        self.unusedLetters = [self initiateUnusedLetters];
        self.unusedLettersInWord = [self initiateunusedLettersInWord:self.pickedWord];
        self.score = 1;
        self.display = [self maskWord:self.pickedWord withSet:self.unusedLettersInWord];
    }
    return self;
}

/*****
 * Create a set filled with 26 capital letters.
 *****/
- (NSMutableSet *)initiateUnusedLetters {
    
    NSMutableSet *letters = [NSMutableSet setWithCapacity:26];
    for (int i = 'A'; i <= 'Z'; i++) {
        [letters addObject:[NSString stringWithFormat:@"%c", i]];
    }
    
    return letters;
}

/*****
 * Create a set filled with the letters in a given string.
 *****/
- (NSMutableSet *)initiateunusedLettersInWord:(NSString *)word {
    
    NSMutableSet *unusedLettersInWord = [NSMutableSet set];
    for (int i = 0; i < [word length]; i++) {
        [unusedLettersInWord addObject:[NSString stringWithFormat:@"%c", [word characterAtIndex:i]]];
    }
    
    return unusedLettersInWord;
}

/*****
 * Mask the unguessed letters by replacing the letters in the word that
 * do not occur in the set of characters that make up the word with hyphens.
 *****/
- (NSString *)maskWord:(NSString *)word withSet:(NSSet *)set {
    NSMutableString *displayWord = [NSMutableString stringWithString:self.pickedWord];
    for (NSString* letter in self.unusedLetters) {
        [displayWord replaceOccurrencesOfString:letter withString:@"-" options:0 range:NSMakeRange(0, [word length])];
    }
    
    return displayWord;
}

/*****
 * TODO.
 *****/
- (NSString *)input:(char)letter {
    
    NSString *guess = [NSString stringWithFormat:@"%c", letter];
    
    // Check whether the letter has not already been guessed.
    if ([self.unusedLettersInWord containsObject:guess]) {
        
        [self.unusedLettersInWord removeObject:guess];
        
        if ([self.unusedLettersInWord count] == 0) {
            // Win game.
            NSLog(@"YAY");
        }
        
        [self.unusedLetters removeObject:guess];
        self.display = [self maskWord:self.pickedWord withSet:self.unusedLettersInWord];
        return @"Correct!";
    }
    else if (![self.unusedLetters containsObject:guess]) {
        // If the letter has been guessed previously inform the player.
        return @"You already guessed this letter.";
    }
    // Else the user must have guessed a wrong letter so remove it from the list and tally a mistake.
    [self.unusedLetters removeObject:guess];
    self.mistakes--;
    
    // Check whether the user has lost the game.
    if (self.mistakes == 0) {
        // Lose game.
        NSLog(@"BOO");
    }
    
    return @"Wrong!";
}

@end
