//
//  TDHGameplay.m
//  Hangman
//
//  Created by Thomas van Dam on 13/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import "TDHGameplay.h"

@interface TDHGameplay ()

@property (readwrite) NSString *pickedWord;
@property (readwrite) int mistakes;
@property (readwrite) NSMutableSet *unusedLetters;
@property (readwrite) int score;

@end

@implementation TDHGameplay

+ (id)newGameWithWordLength:(int)wordLength mistakes:(int)mistakes {
    return [[self alloc] initStub];
}

- (id)initStub {
    self = [super init];
    
    if (self) {
        // TODO
        self.pickedWord = [NSString stringWithFormat:@"BEAR"];
        self.mistakes = 6;
        self.unusedLetters = [self initiateLetters];
        self.score = 1;
    }
    
    return self;
}

+ (id)resumeGameWithWord:(NSString *)word unusedLetters:(NSMutableSet *)unusedLetters mistakesRemaining:(int)mistakes score:(int)score{
    return [[self alloc] initStub];
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
