//
//  TDHHighscores.m
//  Hangman
//
//  Created by Thomas van Dam on 18/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import "TDHHighscores.h"

@implementation TDHHighscores

- (BOOL)saveHighscore:(int)score mistakesMade:(int)mistakes withWord:(NSString *)word {
    // Find the lowest score in the database.
    sqlite3_stmt    *statement;
    NSString *minScore = [NSString stringWithFormat:@" SELECT min(score) FROM scores"];
    const char *min_stmt = [minScore UTF8String];
    int min;
    if(sqlite3_prepare_v2(self.database, min_stmt, -1, &statement, nil) == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW) {
            min = sqlite3_column_int(statement, 0);
        }
        sqlite3_finalize(statement);
    } else {
        return false;
    }
    
    // Save the score if it is higher than the lowest highscore.
    if (score > min) {
    
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO scores (score, mistakes, word) VALUES (%i, %i, \"%@\")", score, mistakes, word];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(self.database, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"Highscore saved.");
        } else {
            NSLog(@"Highscore not saved.");
        }
        sqlite3_finalize(statement);

        // Delete the previous lowest score.
        NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM scores WHERE score = %i)", min];
        
        const char *delete_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(self.database, delete_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"Lowest highscore deleted.");
        } else {
            NSLog(@"Lowest highscore not deleted.");
        }
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(self.database);
    return false;
}

- (NSArray *)getHighscores {
    
    NSMutableArray *highscores = [NSMutableArray arrayWithCapacity:10];
    
    sqlite3_stmt *statement = nil;
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM scores"];
    const char *sql = [query UTF8String];
    
    if (sqlite3_prepare_v2(self.database, sql, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"%s SQL error '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(self.database), sqlite3_errcode(self.database));
    } else {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSMutableArray *result = [NSMutableArray array];
            
            NSNumber *score = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
            [result addObject:score];
            NSNumber *mistakes = [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
            [result addObject:mistakes];
            const unsigned char *word = sqlite3_column_text(statement, 2);
            NSString *wordString = [NSString stringWithFormat:@"%s", word];
            [result addObject:wordString];
            
            [highscores addObject:result];
        }
        // Close the connection to the database to preserve memory.
        sqlite3_finalize(statement);
        sqlite3_close(self.database);
        return highscores;
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(self.database);
    return nil;
}

@end
