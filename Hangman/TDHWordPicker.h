//
//  TDHWordPicker.h
//  Hangman
//
//  Created by Thomas van Dam on 13/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface TDHWordPicker : NSObject

@property (strong) NSString *databasePath;
@property sqlite3 *database;

- (id)init;

- (NSString *)pickWordWith:(int)size;

@end
