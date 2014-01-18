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
        return true;
    }
    
    return false;
}

@end
