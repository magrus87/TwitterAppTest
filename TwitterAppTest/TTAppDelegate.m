//
//  TTAppDelegate.m
//  TwitterAppTest
//
//  Created by Александр Макаров on 17.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import "TTAppDelegate.h"

#define kMainStoryboardName         @"Main"

@implementation TTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor customBlueColor],
                                                           }];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    [[TTManagerData shared] removeObserver:self.window.rootViewController forKeyPath:@"accountTwits"];
    [[TTManagerData shared] removeObserver:self.window.rootViewController forKeyPath:@"searchTwits"];
    [[TTManagerData shared] removeObserver:self.window.rootViewController forKeyPath:@"searchUsers"];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[TTManagerData shared] saveTwitsList];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[TTManagerData shared] addObserver:self.window.rootViewController forKeyPath:@"accountTwits" options:NSKeyValueObservingOptionNew context:nil];
    [[TTManagerData shared] addObserver:self.window.rootViewController forKeyPath:@"searchTwits" options:NSKeyValueObservingOptionNew context:nil];
    [[TTManagerData shared] addObserver:self.window.rootViewController forKeyPath:@"searchUsers" options:NSKeyValueObservingOptionNew context:nil];
    [[TTManagerData shared] restoreTwitsList];

    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
