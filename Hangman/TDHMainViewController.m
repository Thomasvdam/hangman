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
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;
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

/*****
 * Immediately upon pressing a key check whether it was a valid character,
 * convert it to uppercase, pass it to the model, and update the view.
 * Afterwards clear the textfield so the next keypress will be registered 
 * as a single character as well.
 ****/
- (IBAction)textFieldInput:(id)sender {
    UITextField *textField = (UITextField *)sender;
    
    // Capitalise the character and check whether it is a letter.
    char inputChar = [[textField.text capitalizedString] characterAtIndex:0];
    if (('A' <= inputChar) && (inputChar <= 'Z')) {
        [self updateViewWithMessage:[self.gameplay input:inputChar]];
    }

    [textField setText:@""];
}

/*****
 * Update the view with the new values of the model, plus the string with
 * feedback for the user.
 ****/
- (void)updateViewWithMessage:(NSString *)message {
    self.mainLabel.text = self.gameplay.display;
    self.feedbackLabel.text = message;
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
