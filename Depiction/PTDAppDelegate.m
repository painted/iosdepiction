//
//  PTDAppDelegate.m
//  Depiction
//
//  Created by Will Allen on 26/03/2014.
//  Copyright (c) 2014 Painted Ltd. All rights reserved.
//

#import "PTDAppDelegate.h"

@implementation PTDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];*/
    
    // tell the Parse SDK which application ID to use
    
    [Parse setApplicationId:@"QtO3nAD9vMFLBZDOMKG62D2KTpZwatmMslTRXgwf" clientKey:@"AXtRGyQVMFkOCB0t7W4ZRhJb8ox5Kx9qnaLgiUnf"];
    
    // trying my own Parse SDK database
    //[Parse setApplicationId:@"oeFMnX1pAHsAz2CH5y74L68AKk8oybpISZaLdbi1" clientKey:@"LZAg6MAtvvZDuh1wdhqLZ6HKEV5FI07x459ripe1"];
    
    [self setTheme];
    
    
    
    return YES;
}

- (void)setTheme {
    
    [self.window setTintColor:[UIColor greenColor]];
    
    [[UIRefreshControl appearance] setTintColor:[UIColor greenColor]];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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





