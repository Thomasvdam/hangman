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
@property NSUserDefaults *defaults;

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
        TDHWordPicker *wordPicker = [[TDHWordPicker alloc] initWithDatabaseName:WORD_LIST_DB];
        self.pickedWord = [wordPicker pickWordWith:wordLength];
        self.mistakes = mistakes;
        self.unusedLetters = [self initiateUnusedLetters];
        self.unusedLettersInWord = [self initiateUnusedLettersInWord:self.pickedWord];
        self.score = 0;
        self.display = [self maskWord:self.pickedWord withSet:self.unusedLettersInWord];
        self.defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

/*****
 * Create an instance of the gameplay class based on the state of a previous game.
 *****/
+ (id)resumeGameWithWord:(NSString *)word unusedLetters:(NSMutableSet *)unusedLetters mistakesRemaining:(int)mistakes score:(int)score {
    return [[self alloc] initGameWithWord:(NSString *)word unusedLetters:(NSMutableSet *)unusedLetters mistakesRemaining:(int)mistakes score:(int)score];
}

- (id)initGameWithWord:(NSString *)word unusedLetters:(NSMutableSet *)unusedLetters mistakesRemaining:(int)mistakes score:(int)score {
    self = [super init];
    
    if (self) {
        self.pickedWord = word;
        self.mistakes = mistakes;
        self.unusedLetters = unusedLetters;
        NSSet *tempSet = [self initiateUnusedLettersInWord:self.pickedWord];
        self.unusedLettersInWord = [NSMutableSet set];
        for (NSString *letter in self.unusedLetters) {
            if ([tempSet containsObject:letter]) {
                [self.unusedLettersInWord addObject:letter];
            }
        }
        self.score = score;
        self.display = [self maskWord:self.pickedWord withSet:self.unusedLettersInWord];
        self.defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

/*****
 * Create an instance of the gameplay class for basic testing.
 *****/
+ (id)newTestGame {
    return [[self alloc] initForTest];
}

- (id)initForTest {
    self = [super init];
    if (self) {
        self.pickedWord = @"DUCK";
        self.mistakes = 4;
        self.unusedLetters = [self initiateUnusedLetters];
        self.unusedLettersInWord = [self initiateUnusedLettersInWord:self.pickedWord];
        self.score = 0;
        self.display = [self maskWord:self.pickedWord withSet:self.unusedLettersInWord];
        self.defaults = [NSUserDefaults standardUserDefaults];
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
- (NSMutableSet *)initiateUnusedLettersInWord:(NSString *)word {
    
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
- (int)input:(char)letter {

    NSString *guess = [NSString stringWithFormat:@"%c", letter];
    
    // Check whether the letter has not already been guessed.
    if ([self.unusedLettersInWord containsObject:guess]) {
        
        [self.unusedLettersInWord removeObject:guess];
        
        if ([self.unusedLettersInWord count] == 0) {
            // Win game.
            [self.defaults setBool:NO forKey:@"inProgress"];
            [self.defaults synchronize];
            return 4;
        }
        
        [self.unusedLetters removeObject:guess];
        self.display = [self maskWord:self.pickedWord withSet:self.unusedLettersInWord];
        return 1;
    }
    else if (![self.unusedLetters containsObject:guess]) {
        // If the letter has been guessed previously inform the player.
        return 3;
    }
    // Else the user must have guessed a wrong letter so remove it from the list and tally a mistake.
    [self.unusedLetters removeObject:guess];
    self.mistakes--;
    self.score++;
    
    // Check whether the user has lost the game.
    if (self.mistakes == 0) {
        // Lose game.
        [self.defaults setBool:NO forKey:@"inProgress"];
        [self.defaults synchronize];
        return 5;
    }
    
    return 2;
}

- (void)saveGame {
    [self.defaults setObject:self.pickedWord forKey:@"pickedWord"];
    [self.defaults setObject:[self.unusedLetters allObjects] forKey:@"unusedLetters"];
    [self.defaults setInteger:self.mistakes forKey:@"mistakes"];
    [self.defaults setInteger:self.score forKey:@"score"];
    [self.defaults synchronize];
}

@end
