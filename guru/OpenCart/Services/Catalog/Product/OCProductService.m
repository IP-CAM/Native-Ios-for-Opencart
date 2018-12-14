//
//  OCProductService.m
//  OpenCartKit
//
//  Created by icoco7 on 6/22/15.
//  Copyright (c) 2015 i2Cart.com. All rights reserved.
//

#import "OCProductService.h"

@implementation OCProductService

/*
 * @function search
 * @keywords
 * @page
 *
 * @ref: http://127.0.0.1/oc2.0.3/index.php?route=product/search&search=iphone&page=1&json
 */
+ (instancetype)search:(NSString*)keywords page:(NSUInteger)page_i{
    OCProductService* service = [[OCProductService alloc]init];
    
    NSString* route = @"feed/rest_api/product/search";
    service.route = route;
    NSString* search = keywords;
    NSNumber* page = [NSNumber numberWithInteger:page_i];
    
    service.parameters = OCNSDictionaryOfParametersBindingsJson(page,search);
    
    return service;
}

/*
 * @function getProudctsByCategoryId
 *
 * @categoryId  category id
 *
 * @ref: http://127.0.0.1/oc2.0.3/index.php?route=product/category&path=20&json
 */
+ (instancetype)getProudctsByCategoryId:(NSString*)categoryId{
    OCProductService* service = [[OCProductService alloc]init];
    
    NSString* category = categoryId;
   // NSString* limit = @"6";
    NSString* route = @"feed/rest_api/products";
    service.route = route;
    service.parameters = OCNSDictionaryOfParametersBindingsJson (category);

    return service;
}

+ (instancetype)getProudctsByCategoryId:(NSString*)categoryId filter:(NSString*)filter{
    OCProductService* service = [[OCProductService alloc]init];
    
    NSString* category = categoryId;
    NSString* filters = filter;
    // NSString* limit = @"6";
    NSString* route = @"feed/rest_api/products";
    service.route = route;
    service.parameters = OCNSDictionaryOfParametersBindingsJson (category);
    
    return service;
}


/*
 * @function getProudct
 *
 * @productId  product id
 *
 * @ref: http://127.0.0.1/oc2.0.3/index.php?route=product/product&product_id=42&json
 */
+ (instancetype)getProudct:(NSString*)productId{
    OCProductService* service = [[OCProductService alloc]init];
    
    NSString* route = @"feed/rest_api/product/product";
    NSString* product_id = productId;
    service.route = route;
    service.parameters = OCNSDictionaryOfParametersBindingsJson(product_id);
    
    return service;
}

+ (instancetype)getBestSeller{
    OCProductService* service = [[OCProductService alloc]init];
    
   // NSDictionary * para = @{@"X-Oc-Merchant-Id":@"04exmjdONzS1VkxjZK16mtU8TXJ0dnNM",@"limit":@"2"};
    NSString* route = @"feed/rest_api/bestsellers";
    service.route = route;
   // service.parameters = para;//OCNSDictionaryOfParametersBindingsJson (route);
    
    return service;
}

+ (instancetype)getLatestproduct{
    OCProductService* service = [[OCProductService alloc]init];
    
    NSDictionary * para = @{@"X-Oc-Merchant-Id":@"04exmjdONzS1VkxjZK16mtU8TXJ0dnNM"};
    NSString* route = @"feed/rest_api/latest";
    service.route = route;
    service.parameters = para;//OCNSDictionaryOfParametersBindingsJson (route);
    
    return service;
}

+ (instancetype)getFeaturedproduct{
    OCProductService* service = [[OCProductService alloc]init];
    
    NSDictionary * para = @{@"X-Oc-Merchant-Id":@"04exmjdONzS1VkxjZK16mtU8TXJ0dnNM"};
    NSString* route = @"feed/rest_api/featured";
    service.route = route;
    service.parameters = para;//OCNSDictionaryOfParametersBindingsJson (route);
    
    return service;
}

@end
