//
//  AppManager.h
//  icoco
//
//  Created by icoco on 31/07/2008.
//  Copyright 2008 i2cart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppManager : NSObject

+(AppManager*) sharedInstance;

-(void) startApp;
-(void) terminateApp;
-(void) setupWorkSpace;

-(void) setKeyWindow:(UIWindow*) aWindow;
-(UIView*) getKeyWindow;

 
-(void)setMainViewController:(UIViewController*) aViewController;
-(UIViewController*)getMainViewController;

-(void)showHomeViewInKeyWindow:(int)selectedIndex;
 
-(void)showCoverView;

@end
