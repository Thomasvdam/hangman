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

@end

@implementation GameplayTests

- (void)setUp
{
    NSLog(@"Setting up %@", self.name);
    [super setUp];
    
    // Allocate and initiate new gameplay model.
    TDHGameplay *gameplay = [TDHGameplay newGameWithWordLength:4 mistakes:4];
    
    XCTAssertNotNil(gameplay, @"Cannot create model instance.");
}

- (void)tearDown
{
    NSLog(@"Tearing down %@", self.name);
    [super tearDown];
}

- (void)testExample
{
    
}

@end
