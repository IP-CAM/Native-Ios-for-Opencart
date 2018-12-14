//
//  AppDelegate.m
//  guru
//
//  Created by Amit on 8/9/18.
//  Copyright © 2018 Amit. All rights reserved.
//

#import "AppDelegate.h"
#import "AppManager.h"
#import "OCSessionService.h"
#import "Resource.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
  //  [UINavigationBar appearance].backgroundColor = UIColor.greenColor;
  //  [UITabBar appearance].tintColor = UIColor.greenColor;
    [[AppManager sharedInstance] startApp];

    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.36 green:0.60 blue:0.11 alpha:1.0]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           }];


    [self getSessionForApp];
    
    return YES;
}

- (void)getSessionForApp{
    
    if ([Resource loadUserSessionInfo] == nil) {
        __weak __typeof(self)weakSelf = self;
        
        OCSessionService * serivce = [OCSessionService getSession];
        [serivce execute:^(id response) {
            
            NSDictionary* result = [response objectForKey:@"data"];
            //@step
            
            [Resource storeUserSessionInfo:[result objectForKey:@"session"]];
            
            
        } failure:^(NSError *error) {
            // [CDialogViewManager showMessageView:[error localizedDescription] message:nil delayAutoHide: 3];
            //[weakSelf stopPullToRefreshAnimation];
            
        }];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
