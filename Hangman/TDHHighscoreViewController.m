//
//  TDHHighscoreViewController.m
//  Hangman
//
//  Created by Thomas van Dam on 17/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import "TDHHighscoreViewController.h"

@interface TDHHighscoreViewController ()

@end

@implementation TDHHighscoreViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    TDHHighscores *highscoresModel = [[TDHHighscores alloc] initWithDatabaseName:HIGH_SCORE_DB];
    self.highscores = [highscoresModel getHighscores];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.highscores count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSArray *highscore = [self.highscores objectAtIndex:indexPath.row];
    cell.textLabel.text = highscore[2];
    
    return cell;
}

#pragma mark - done

- (IBAction)done:(id)sender
{
    [self.delegate highscoreViewControllerDidFinish:self];
}

@end
