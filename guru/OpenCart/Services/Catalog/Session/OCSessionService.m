//
//  OCSessionService.m
//  AFNetworking
//
//  Created by Amit on 10/16/18.
//

#import "OCSessionService.h"

@implementation OCSessionService

+ (instancetype)getSession
{
    OCSessionService* service = [[OCSessionService alloc]init];
    
    NSString* route = @"feed/rest_api/session";
    service.route = route;
    // [service setHeader:para];
    
    //service.parameters = para;//OCNSDictionaryOfParametersBindingsJson (route);
    
    return service;
}

@end
