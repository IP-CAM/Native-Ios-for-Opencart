//
//  OCCategoryService.m
//  OpencartKit
//
//  Created by icoco7 on 6/21/15.
//  Copyright (c) 2015 i2Cart. All rights reserved.
//

#import "OCCategoryService.h"

@implementation OCCategoryService

/*
 * getCategories
 *
 * @parentId  if parentId is 0 then return top categories
 *
 * @ref: http://127.0.0.1/oc2.0.3/index.php?route=category/category&json=1
 */
+ (instancetype)getCategories:(NSString*)parentId{
    OCCategoryService* service = [[OCCategoryService alloc]init];
    
    NSString* route = @"feed/rest_api/categories";
    service.route = route;
   // [service setHeader:para];
    
    //service.parameters = para;//OCNSDictionaryOfParametersBindingsJson (route);
     
    return service;
}


@end
