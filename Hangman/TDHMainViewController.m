//
//  TDHMainViewController.m
//  Hangman
//
//  Created by Thomas van Dam on 09/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import "TDHMainViewController.h"

@interface TDHMainViewController ()

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UITextField *mainTextField;

@end

@implementation TDHMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.mainLabel.text = self.gameplay.display;
    [self.mainTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldInput:(id)sender {
    UITextField *textField = (UITextField *)sender;
    char inputChar = [[textField.text capitalizedString] characterAtIndex:0];
    
    // Check whether the character is a capital letter.
    if (('A' <= inputChar) && (inputChar <= 'Z')) {
        [self.gameplay input:inputChar];
    }
    
    [textField setText:@""];
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(TDHFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.mainTextField becomeFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

@end
