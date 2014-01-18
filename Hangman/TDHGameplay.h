//
//  TDHGameplay.h
//  Hangman
//
//  Created by Thomas van Dam on 13/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDHGameplay : NSObject

@property (readonly) NSString *display;
@property (readonly) NSString *pickedWord;
@property (readonly) int mistakes;
@property (readonly) NSMutableSet *unusedLetters;
@property (readonly) int score;

+ (id)newGameWithWordLength:(int)wordLength mistakes:(int)mistakes;
+ (id)resumeGameWithWord:(NSString *)word unusedLetters:(NSMutableSet *)unusedLetters mistakesRemaining:(int)mistakes score:(int)score;

+ (id)newTestGame;

- (int)input:(char)letter;
- (void)saveGame;

@end
