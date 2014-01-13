//
//  GameplayTests.m
//  Hangman
//
//  Created by Thomas van Dam on 13/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TDHGameplay.h"

@interface GameplayTests : XCTestCase

@property TDHGameplay *gameplay;

@end

@implementation GameplayTests

- (void)setUp
{
    NSLog(@"Setting up %@", self.name);
    [super setUp];
    
    self.gameplay = [TDHGameplay newGameWithWordLength:4 mistakes:8];
    XCTAssertNotNil(self.gameplay, @"Cannot create gameplay instance.");
}

- (void)tearDown
{
    NSLog(@"Tearing down %@", self.name);
    [super tearDown];

}

/*****
 * Tests if a new model is created and if the length of the word and allowed
 * mistakes correspond to the passed paramters.
 *****/
- (void)testNewGame
{
    XCTAssertEqual((int)[self.gameplay.pickedWord length], 4, @"Length of word does not equal passed parameter.");
    XCTAssertEqual(self.gameplay.mistakes, 8, @"Amount of mistakes allowed does not equal passed parameter.");
}

@end
