//
//  TDHFlipsideViewController.h
//  Hangman
//
//  Created by Thomas van Dam on 09/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TDHFlipsideViewController;

@protocol TDHFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(TDHFlipsideViewController *)controller;
@end

@interface TDHFlipsideViewController : UIViewController

@property (weak, nonatomic) id <TDHFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
