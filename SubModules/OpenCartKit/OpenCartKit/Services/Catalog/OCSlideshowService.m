//
//  OCSlideshow.m
//  AFNetworking
//
//  Created by Amit on 10/11/18.
//

#import "OCSlideshowService.h"

@implementation OCSlideshowService

+ (instancetype)getSlideshow{
    OCSlideshowService* service = [[OCSlideshowService alloc]init];
    
    NSDictionary * para = @{@"X-Oc-Merchant-Id":@"04exmjdONzS1VkxjZK16mtU8TXJ0dnNM"};
    NSString* route = @"slideshows";
    service.route = route;
   // service.parameters = para;//OCNSDictionaryOfParametersBindingsJson (route);
    
    return service;
}

@end
