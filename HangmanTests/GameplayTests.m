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
    [super setUp];
    
    self.gameplay = [TDHGameplay newTestGame];
}

- (void)tearDown
{
    [super tearDown];

}

/*****
 * Tests if a new model is created and if the properties of the model are in
 * accordance with the passed parameters.
 *****/
- (void)testNewGameWithWordLengthAndMistakes
{
    TDHGameplay *newGame = [TDHGameplay newGameWithWordLength:4 mistakes:8];
    XCTAssertNotNil(newGame, @"Cannot create gameplay instance.");
    XCTAssertEqual((int)[newGame.display length], 4, @"Length of word does not equal passed parameter.");
    XCTAssertEqual(newGame.mistakes, 8, @"Amount of mistakes allowed does not equal passed parameter.");
    XCTAssertNotNil(newGame.unusedLetters, @"Cannot create capitalised alphabet set.");
}

/*****
 * Tests whether correct input is processed correctly.
 ****/
- (void)testCorrectInput
{
    char testInput = 'K';
    [self.gameplay input:testInput];
    XCTAssertTrue([self.gameplay.unusedLetters count] == 25, @"Guessed letter is not removed from unusedLetter set.");
    XCTAssertTrue([self.gameplay.display isEqualToString:@"---K"], @"Guessed letter is not revealed in the masked display string.");
    XCTAssertTrue(self.gameplay.mistakes == 4, @"Correct guess changes the mistakes property.");
}

/*****
 * Tests whether incorrect input is processed correctly.
 ****/
- (void)testIncorrectInput
{
    char testInput = 'L';
    [self.gameplay input:testInput];
    XCTAssertTrue([self.gameplay.unusedLetters count] == 25, @"Guessed letter is not removed from unusedLetter set.");
    XCTAssertTrue([self.gameplay.display isEqualToString:@"----"], @"Masked display string is altered with incorrect input.");
    XCTAssertTrue(self.gameplay.mistakes == 3, @"Incorrect guess does not change the mistakes property properly.");
}

/*****
 * Tests whether double correct input is processed correctly.
 ****/
- (void)testDoubleCorrectInput
{
    char testInput = 'K';
    [self.gameplay input:testInput];
    [self.gameplay input:testInput];
    XCTAssertTrue([self.gameplay.unusedLetters count] == 25, @"Guessing a correct letter again alters unusedLetter set.");
    XCTAssertTrue([self.gameplay.display isEqualToString:@"---K"], @"Guessing a correct letter again changes the masked display string.");
    XCTAssertTrue(self.gameplay.mistakes == 4, @"Double correct guess changes the mistakes property.");
}

/*****
 * Tests whether double incorrect input is processed correctly.
 ****/
- (void)testDoubleIncorrectInput
{
    char testInput = 'L';
    [self.gameplay input:testInput];
    [self.gameplay input:testInput];
    XCTAssertTrue([self.gameplay.unusedLetters count] == 25, @"Guessing an incorrect letter again alters unusedLetter set.");
    XCTAssertTrue([self.gameplay.display isEqualToString:@"----"], @"Masked display string is altered with double incorrect input.");
    XCTAssertTrue(self.gameplay.mistakes == 3, @"Double incorrect guesses changes the mistakes property.");
}

@end
