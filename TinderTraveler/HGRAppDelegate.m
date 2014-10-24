//
//  HGRAppDelegate.m
//  TinderTraveler
//
//  Created by Chan Komagan on 10/15/14.
//  Copyright (c) 2014 Chan Komagan. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>

#import "HGRAppDelegate.h"
#import "SignInController.h"
#import "SettingsController.h"

@implementation HGRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [FBLoginView class];
    [FBProfilePictureView class];
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    return wasHandled;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
  
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[FBSession activeSession] handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[FBSession activeSession] close];
}

@end
