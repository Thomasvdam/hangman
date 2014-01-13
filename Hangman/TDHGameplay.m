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

@property (readwrite) NSString *pickedWord;
@property (readwrite) int mistakes;
@property (readwrite) NSMutableSet *unusedLetters;
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
        self.unusedLetters = [self initiateLetters];
        self.score = 1; // TODO!
    }
    return self;
}

/*****
 * TODO.
 *****/
+ (id)resumeGameWithWord:(NSString *)word unusedLetters:(NSMutableSet *)unusedLetters mistakesRemaining:(int)mistakes score:(int)score{
    return [[self alloc] init];
}

/*****
 * Create a set filled with 26 capital letters.
 *****/
- (NSMutableSet *)initiateLetters {
    
    NSMutableSet *letters = [NSMutableSet setWithCapacity:26];
    
    for (int i = 'A'; i <= 'Z'; i++) {
        [letters addObject:[NSString stringWithFormat:@"%c", i]];
    }
    
    return letters;
}

/*****
 * TODO.
 *****/
- (BOOL)input:(NSString *)letter {
    return false;
}

@end
