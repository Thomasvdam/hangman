//
//  TDHHighscoreViewController.h
//  Hangman
//
//  Created by Thomas van Dam on 17/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDHMainViewController.h"
#import "TDHHighscores.h"

@class TDHHighscoreViewController;

@protocol TDHHighscoreViewControllerDelegate
- (void)highscoreViewControllerDidFinish:(TDHHighscoreViewController *)controller;
@end

@interface TDHHighscoreViewController : UITableViewController

@property (weak, nonatomic) id <TDHHighscoreViewControllerDelegate> delegate;
@property NSArray *highscores;
@property NSArray *result;

@end
