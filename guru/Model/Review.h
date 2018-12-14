//
//  Review.h
//  guru
//
//  Created by Amit on 10/13/18.
//  Copyright © 2018 Amit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Review : NSObject

@property (nonatomic, strong) NSString* author;

@property (nonatomic, strong) NSString* text;

@property (nonatomic, strong) NSNumber* rating;

@property (nonatomic, strong) NSString* date_added;
@end

NS_ASSUME_NONNULL_END
