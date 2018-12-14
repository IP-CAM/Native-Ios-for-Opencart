//
//  Category.h
//  guru
//
//  Created by Amit on 10/13/18.
//  Copyright © 2018 Amit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Category : NSObject

@property (nonatomic, strong) NSNumber* category_id;

@property (nonatomic, strong) NSNumber* parent_id;

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSString* image;

@property (nonatomic, strong) NSString* original_image;

@property (nonatomic, strong) NSDictionary* filters;

@property (nonatomic, strong) NSArray<Category*>* categories;

@end

NS_ASSUME_NONNULL_END
