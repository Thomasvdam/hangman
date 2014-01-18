//
//  TDHHighscores.h
//  Hangman
//
//  Created by Thomas van Dam on 18/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import "TDHDatabaseConnector.h"

@interface TDHHighscores : TDHDatabaseConnector

- (BOOL)saveHighscore:(int)score mistakesMade:(int)mistakes withWord:(NSString *)word;
- (NSArray *)getHighscores;

@end
