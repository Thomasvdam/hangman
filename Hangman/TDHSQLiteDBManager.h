//
//  TDHSQLiteDBManager.h
//  Hangman
//
//  Created by Thomas van Dam on 13/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface TDHSQLiteDBManager : NSObject

@property sqlite3 *database;

- (id)init;

- (NSSet *)wordsWithLength:(int)size;

@end
