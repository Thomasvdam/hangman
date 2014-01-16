//
//  TDHDatabaseConnector.m
//  Hangman
//
//  Created by Thomas van Dam on 16/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import "TDHDatabaseConnector.h"

@implementation TDHDatabaseConnector

/*****
 * Initialise an instance of the class with a connection to the database.
 *****/
- (id)initWithDatabaseName:(NSString *)databaseName {
    self = [super init];
    
    if (self) {
        
        self.databaseName = databaseName;
        
        // Build the path to the database file if it exists
        [self copyDatabase];
        _databasePath = [NSString stringWithString:[self findDatabasePath]];
        
        const char *dbpath = [_databasePath UTF8String];
        sqlite3 *dbConnection;
        if (sqlite3_open_v2(dbpath, &dbConnection, SQLITE_OPEN_READWRITE, NULL) != SQLITE_OK) {
            
            NSLog(@"[SQLITE] Unable to open database!");
            return nil;
        }
        self.database = dbConnection;
    }
    return self;
}

/*****
 * Find the path to the database.
 *****/
- (NSString*)findDatabasePath {
    NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *DocumentDir = [Paths objectAtIndex:0];
    return [DocumentDir stringByAppendingPathComponent:self.databaseName];
}

/*****
 * Check wheter the database is already there, and if not copy it from the bundle.
 *****/
- (void)copyDatabase
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:[self findDatabasePath]];
    NSString *FileDB = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:self.databaseName];
    
    if (success) {
        NSLog(@"File Exist");
        return;
    } else {
        [fileManager copyItemAtPath:FileDB toPath:[self findDatabasePath] error:nil];
    }
}

@end
