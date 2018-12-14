//
//  Product.h
//  guru
//
//  Created by Amit on 10/13/18.
//  Copyright © 2018 Amit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Review.h"

NS_ASSUME_NONNULL_BEGIN

@interface Product : NSObject

@property (nonatomic, strong) NSNumber* id;

@property (nonatomic, strong) NSNumber* product_id;

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSString* manufacturer;

@property (nonatomic, strong) NSString* sku;

@property (nonatomic, strong) NSString* model;

@property (nonatomic, strong) NSString* image;

@property (nonatomic, strong) NSArray<NSString*>* images;

@property (nonatomic, strong) NSString* original_image;

@property (nonatomic, strong) NSArray<NSString*>* original_images;

@property (nonatomic, strong) NSNumber* price_excluding_tax;

@property (nonatomic, strong) NSString* price_excluding_tax_formated;

@property (nonatomic, strong) NSNumber* price;

@property (nonatomic, strong) NSString* price_formated;

@property (nonatomic, strong) NSNumber* rating;

@property (nonatomic, strong) NSString* description_product;

@property (nonatomic, strong) NSString* stock_status;

@property (nonatomic, strong) NSDictionary* reviews;


@end

NS_ASSUME_NONNULL_END
