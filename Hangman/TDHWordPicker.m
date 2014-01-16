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
    
    if (sqlite3_prepare_v2(self.database, sql, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"%s SQL error '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(self.database), sqlite3_errcode(self.database));
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
            if (value) {
                [result addObject:value];
            }
        }
        return result;
    }
    return nil;
}

@end
