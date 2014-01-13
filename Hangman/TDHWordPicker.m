//
//  TDHWordPicker.m
//  Hangman
//
//  Created by Thomas van Dam on 13/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import "TDHWordPicker.h"

@implementation TDHWordPicker

/*****
 * Initialise an instance of the class with a connection to the database.
 *****/
- (id)init {
    self = [super init];
    
    if (self) {
        
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
    return [DocumentDir stringByAppendingPathComponent:@"wordList.sqlite"];
}

/*****
 * Check wheter the database is already there, and if not copy it from the bundle.
 *****/
- (void)copyDatabase
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:[self findDatabasePath]];
    NSString *FileDB = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"wordList.sqlite"];
    
    if (success) {
        NSLog(@"File Exist");
        return;
    } else {
        [fileManager copyItemAtPath:FileDB toPath:[self findDatabasePath] error:nil];
    }
}

/*****
 * Return a random word of the given length.
 *****/
- (NSString *)pickWordWith:(int)size {
    NSArray *words = [self wordsWithLength:size];
    
    if ([words count] != 0) {
        int randomIndex = arc4random_uniform([words count]);
    
        NSString *pickedWord = [words objectAtIndex:randomIndex];
    
        return pickedWord;
    }
    
    return nil;
}

/*****
 * Create an NSArray filled with all words of a given size in the database.
 *****/
- (NSArray *)wordsWithLength:(int)size {
        
    sqlite3_stmt *statement = nil;
    NSString *query = [NSString stringWithFormat:@"SELECT word FROM words WHERE size = %i", size];
    const char *sql = [query UTF8String];
    
    if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"%s SQL error '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(_database), sqlite3_errcode(_database));
        NSLog(@"[SQLITE] Error when preparing query!");
    } else {
        NSMutableArray *result = [NSMutableArray array];
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSString *value;
            int colType = sqlite3_column_type(statement, 0);
            if (colType == SQLITE_TEXT) {
                const unsigned char *col = sqlite3_column_text(statement, 0);
                value = [NSString stringWithFormat:@"%s", col];
            } else {
                NSLog(@"[SQLITE] UNKNOWN DATATYPE");
            }
            [result addObject:value];
        }
        return result;
    }
    return nil;
}

@end
