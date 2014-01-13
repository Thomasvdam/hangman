//
//  TDHMainViewController.h
//  Hangman
//
//  Created by Thomas van Dam on 09/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import "TDHFlipsideViewController.h"
#import "TDHGameplay.h"

@interface TDHMainViewController : UIViewController <TDHFlipsideViewControllerDelegate>

@property (weak) TDHGameplay *gameplay;

@end
