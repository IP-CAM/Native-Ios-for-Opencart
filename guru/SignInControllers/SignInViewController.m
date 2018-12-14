//
//  SignInViewController.m
//  guru
//
//  Created by Amit on 10/13/18.
//  Copyright © 2018 Amit. All rights reserved.
//

#import "SignInViewController.h"
#import "OpenCartConstant.h"
#import "Lang.h"
#import "OpenCartKit.h"

@interface SignInViewController (){
    OCCustomer* _activeUser;
}

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)signIn:(id)sender {
    [self registeration];
   // [self login:self.email.text password:self.password.text];
}

- (void)login:(NSString*) email password:(NSString*)password {
    
    if ([Lang isEmptyString:email] || [Lang isEmptyString:password]) {
        return;
    }
    __weak __typeof(self)weakSelf = self;
    OCAccountService* serivce = [OCAccountService login:email password:password];
    [serivce execute:^(id response) {
        [weakSelf onLoginDone:response];
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)registeration {
    
    __weak __typeof(self)weakSelf = self;
    OCAccountService* serivce = [OCAccountService register:@"testing" lastname:@"ios" email:@"test_ios@gmail.com" password:@"123456" confirm:@"123456" telephone:@"7896745637" fax:@"" company:@"" address_1:@"Gurgaon" address_2:@"" city:@"UP" postcode:@"800783" country_id:@"99" zone_id:@"1505" agree:YES newsletter:YES];
    [serivce execute:^(id response) {
        NSLog(@"reg success");
      //  [weakSelf onLoginDone:response];
    } failure:^(NSError *error) {
        NSLog(@"reg fail");
    }];
    
}
#pragma Account
- (BOOL)onLoginDone:(id)response{
    
    if ([response isKindOfClass:[OCCustomer class]]) {
        OCCustomer* user = (OCCustomer*)response;
        if (nil !=user && [user isValidateUser]) {
            //@step login succcess
            _activeUser = user;
            //@step
            [self resetWorkSpace];
            return true;
        }
    }
    
    //@step faield login
    [self cleanUpUserAccountInfo];
    //@step
    NSString* mssage = @"Failed login";
    
    if ( nil != response &&[response isKindOfClass:[NSException class]]){
        
        NSException* error = (NSException*)response;
        mssage = [error description];
    }
    
    //  [CDialogViewManager showMessageView:@"" message:mssage delayAutoHide: -1];
    return false;
}

#pragma mark cache the user account information
- (void)cleanUpUserAccountInfo
{
    NSDictionary* dict =[NSDictionary dictionary];
    //  [Resource storeUserAccountInfo:dict];
}

- (void)resetWorkSpace{
    [self loadCart];
}

#pragma -mark Cart
#pragma -mark list product
- (void)loadCart{
    
    OCCartService *serivce = [OCCartService getProducts];
    [serivce execute:^(id response) {
        
        NSDictionary* dict = (NSDictionary*)response;
        NSArray* list = (NSArray*)[dict objectForKey:@"products"];
        [self onEventCartUpdated:list];
        
    } failure:^(NSError *error) {
        // [CDialogViewManager showMessageView:@"" message:[error localizedDescription] delayAutoHide:-1];
    }];
    
}
- (void)onEventCartUpdated:(NSArray*)products
{
    //@step
    NSUInteger count = [products count];
    
    
    int iquantity = 0;
    //@step
    //    for (int i=0; i < count; i++) {
    //        NSDictionary* item = [products objectAtIndex:i];
    //        NSNumber* quantity = [item valueForKey:Product_quantity];
    //        iquantity = iquantity + [quantity intValue];
    //    }
    //
    //    NSString* countString = [NSString stringWithFormat:@"%d", iquantity];
    //    [Resource notifyCartUpdate:countString];
}

- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
