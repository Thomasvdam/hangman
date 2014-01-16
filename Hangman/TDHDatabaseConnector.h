//
//  TDHDatabaseConnector.h
//  Hangman
//
//  Created by Thomas van Dam on 16/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface TDHDatabaseConnector : NSObject

@property NSString *databasePath;
@property sqlite3 *database;
@property NSString *databaseName;

- (id)initWithDatabaseName:(NSString *)databaseName;

@end
