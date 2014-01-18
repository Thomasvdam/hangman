//
//  TDHAppDelegate.m
//  Hangman
//
//  Created by Thomas van Dam on 09/01/2014.
//  Copyright (c) 2014 Thomas van Dam. All rights reserved.
//

#import "TDHAppDelegate.h"
#import "TDHGameplay.h"
#import "TDHMainViewController.h"

@implementation TDHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Get the user defaults.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Set default user defaults on first launch.
    if(![defaults boolForKey:@"firstRun"]) {
        [defaults setInteger:8 forKey:@"mistakesVal"];
        [defaults setInteger:4 forKey:@"wordLengthVal"];
        // 'Save'.
        [defaults setBool:YES forKey:@"firstRun"];
        [defaults synchronize];
    }

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults boolForKey:@"inProgress"]) {
        TDHMainViewController *mainView = (TDHMainViewController *)self.window.rootViewController;
        [mainView.gameplay saveGame];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
