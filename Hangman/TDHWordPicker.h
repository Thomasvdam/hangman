//
//  TDHWordPicker.h
//  Hangman
//
//  Created by Thomas van Dam on 13/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDHDatabaseConnector.h"

@interface TDHWordPicker : TDHDatabaseConnector

- (NSString *)pickWordWith:(int)size;

@end
