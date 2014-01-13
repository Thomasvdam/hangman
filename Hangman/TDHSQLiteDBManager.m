//
//  TDHSQLiteDBManager.m
//  Hangman
//
//  Created by Thomas van Dam on 13/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import "TDHSQLiteDBManager.h"

@implementation TDHSQLiteDBManager

- (id)init {
    if (self = [super init]) {
        sqlite3 *dbConnection;
        if (sqlite3_open([@"wordList.sqlite" UTF8String], &dbConnection) != SQLITE_OK) {
            
            NSLog(@"[SQLITE] Unable to open database!");
            return nil; // if it fails, return nil obj
        }
        self.database = dbConnection;
    }
    return self;
}

- (NSSet *)wordsWithLength:(int)size {
    sqlite3_stmt *statement = nil;
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM words WHERE size = %d", size];
    const char *sql = [query UTF8String];
    if (sqlite3_prepare_v2(self.database, sql, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"[SQLITE] Error when preparing query!");
    } else {
        NSMutableSet *result = [NSMutableSet set];
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSString *value;
            for (int i=0; i<sqlite3_column_count(statement); i++) {
                int colType = sqlite3_column_type(statement, i);
                if (colType == SQLITE_TEXT) {
                    const unsigned char *col = sqlite3_column_text(statement, i);
                    value = [NSString stringWithFormat:@"%s", col];
                } else {
                    NSLog(@"[SQLITE] UNKNOWN DATATYPE");
                }
            }
            [result addObject:value];
        }
        return result;
    }
    return nil;
}

@end
