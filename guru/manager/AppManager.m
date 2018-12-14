//
//  AppManager.m
//   icoco
//
//  Created by icoco on 31/07/2008.
//  Copyright 2008 i2cart. All rights reserved.
//
#import "AppManager.h"
#import "Util.h"
#import "Resource.h"
#import "DataModel.h"

static AppManager *  _appManagerInstance = nil;

@implementation AppManager



+(AppManager*) sharedInstance
{
    @synchronized(self) {
        if ( nil == _appManagerInstance)
        {
            _appManagerInstance =  [[AppManager alloc ] init] ;
        }
    }
	return _appManagerInstance;
}



+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (_appManagerInstance == nil) {
            _appManagerInstance = [super allocWithZone:zone];
            return _appManagerInstance;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
 

-(void) startApp{
    
    [OCWebServiceConfig sharedInstance].apiRootUrl =  [Resource getRestEndpoint];
    
}

-(void) terminateApp
{
}

- (void)onNotifyEventCommpleteAddCart:(NSNotification*)notifycation
{
    NSDictionary* dict =[notifycation object];
    
//    [self upateShoppingCartBar:dict];
}

-(void) registerListener {

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotifyEventCommpleteAddCart: )
 												 name: NotifyEventCommpleteAddCart object:nil];


}
-(void) unRegisterListener{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NotifyEventCommpleteAddCart object:nil];

}


@end
