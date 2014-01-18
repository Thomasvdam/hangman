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
@property (weak, nonatomic) IBOutlet UILabel *mistakesLabel;
@property (weak, nonatomic) IBOutlet UITextField *mainTextField;

@end

@implementation TDHMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Initiate a gameplay object and pass the reference to the main view controller.
    if(![defaults boolForKey:@"inProgress"]) {
        self.gameplay = [TDHGameplay newGameWithWordLength:[defaults integerForKey:@"wordLengthVal"] mistakes:[defaults integerForKey:@"mistakesVal"]];
        [defaults setBool:YES forKey:@"inProgress"];
    } else {
        self.gameplay = [TDHGameplay resumeGameWithWord:[defaults stringForKey:@"pickedWord"] unusedLetters:[NSMutableSet setWithArray:[defaults arrayForKey:@"unusedLetters"]] mistakesRemaining:[defaults integerForKey:@"mistakes"] score:[defaults integerForKey:@"score"]];
    }
    
    [self updateViewWithMessage:0];
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
        
        // Pass the input to the model and update view accordingly.
        int feedback = [self.gameplay input:inputChar];
        [self updateViewWithMessage:feedback];
        
        if (feedback == 4) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You won!"
                                                            message:[NSString stringWithFormat:@"Congratulations, the word was indeed %@!", self.gameplay.pickedWord]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [self performSegueWithIdentifier:@"showHighscores" sender:self];
        } else if (feedback == 5) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You lose!"
                                                            message:[NSString stringWithFormat:@"Too bad, the word was %@.", self.gameplay.pickedWord]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [self performSegueWithIdentifier:@"showHighscores" sender:self];
        }
    }

    [textField setText:@""];
}

/*****
 * Update the view with the new values of the model, plus a string with
 * feedback for the user.
 ****/
- (void)updateViewWithMessage:(int)feedback {
    self.mainLabel.text = self.gameplay.display;
    self.mistakesLabel.text = [NSString stringWithFormat:@"Mistakes remaining: %i", self.gameplay.mistakes];
    
    NSString *message;
    switch (feedback) {
        case 0:
            message = [NSString stringWithFormat:@"New game with %lu letters.", (unsigned long)[self.gameplay.display length]];
            break;
            
        case 1:
            message = @"Correct!";
            break;
            
        case 2:
            message = @"Wrong!";
            break;
            
        case 3:
            message = @"You already guessed that letter!";
            break;
        
        default:
            message = @"";
            break;
    }
    
    self.feedbackLabel.text = message;
}

#pragma mark - Highscore View

- (void)highscoreViewControllerDidFinish:(TDHHighscoreViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if(![defaults boolForKey:@"inProgress"]) {
        self.gameplay = [TDHGameplay newGameWithWordLength:[defaults integerForKey:@"wordLengthVal"] mistakes:[defaults integerForKey:@"mistakesVal"]];
        [defaults setBool:YES forKey:@"inProgress"];
    }
    
    [self updateViewWithMessage:0];
    [self.mainTextField becomeFirstResponder];
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
    } else if ([[segue identifier] isEqualToString:@"showHighscores"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

@end
