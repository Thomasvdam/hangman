//
//  TDHHighscores.m
//  Hangman
//
//  Created by Thomas van Dam on 18/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import "TDHHighscores.h"

@implementation TDHHighscores

/*****
 * Save the score and word in the database.
 *****/
- (void)saveHighscore:(int)score withWord:(NSString *)word {
    sqlite3_stmt    *statement;
    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO scores (score, word) VALUES (%i, \"%@\")", score, word];
    
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(self.database, insert_stmt, -1, &statement, NULL);
    if (sqlite3_step(statement) == SQLITE_DONE) {
        NSLog(@"Highscore saved.");
    } else {
        NSLog(@"Highscore not saved.");
    }
    sqlite3_finalize(statement);
}

/*****
 * Return an array containing all the highscores in the database.
 *****/
- (NSArray *)getHighscores {
    
    NSMutableArray *highscores = [NSMutableArray arrayWithCapacity:10];
    
    sqlite3_stmt *statement = nil;
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM scores ORDER BY score ASC"];
    const char *sql = [query UTF8String];
    
    if (sqlite3_prepare_v2(self.database, sql, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"%s SQL error '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(self.database), sqlite3_errcode(self.database));
    } else {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSMutableArray *result = [NSMutableArray array];
            
            NSNumber *score = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
            [result addObject:score];
            const unsigned char *word = sqlite3_column_text(statement, 1);
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
