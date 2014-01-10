//
//  TDHFlipsideViewController.m
//  Hangman
//
//  Created by Thomas van Dam on 09/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import "TDHFlipsideViewController.h"

@interface TDHFlipsideViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mistakesLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLengthLabel;
@property (weak, nonatomic) IBOutlet UISlider *mistakeSlider;
@property (weak, nonatomic) IBOutlet UISlider *wordLengthSlider;

@end

@implementation TDHFlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Get user deafults.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int mistakesVal = [defaults integerForKey:@"mistakesVal"];
    int wordLengthVal = [defaults integerForKey:@"wordLengthVal"];
    
    // Update view with user defaults.
    [self.mistakeSlider setValue:mistakesVal];
    self.mistakesLabel.text = [NSString stringWithFormat:@"%d", mistakesVal];
    [self.wordLengthSlider setValue:wordLengthVal];
    self.wordLengthLabel.text = [NSString stringWithFormat:@"%d", wordLengthVal];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)sliderChanged:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    UISlider *slider = (UISlider *)sender;
    int val = slider.value;
    
    // Update the correct label and default setting.
    if (slider == self.mistakeSlider) {
        self.mistakesLabel.text = [NSString stringWithFormat:@"%d", val];
        [defaults setInteger:val forKey:@"mistakesVal"];
    } else if (slider == self.wordLengthSlider) {
        self.wordLengthLabel.text = [NSString stringWithFormat:@"%d", val];
        [defaults setInteger:val forKey:@"wordLengthVal"];
    }
    
    // Save settings.
    [defaults synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
