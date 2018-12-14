//
//  iSON.h
//  ReveChat
//
//  Created by Amit on 5/15/17.
//  Copyright © 2017 Amit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iSON : NSObject

+ (void)registerObjectByPropertyName:(NSString *)propertyName forClass:(Class)cls;
+ (Class)arrayTypeForPropertyName:(NSString *)propertyName;
+ (NSString *)objectToJSON:(id)object;
+ (NSArray *)objectFromUnnamedArrayJSON:(NSString *)JSON forClass:(Class)cls;
+ (NSString *)arrayToJSON:(NSArray *)items;
+ (id)objectFromJSON:(NSString *)JSON forClass:(Class)className;
+ (void)setDateFormatter:(NSString *)dateFormat;
+ (NSString *)dictionaryToJSON:(NSDictionary *)dict;
+ (id)objectFromDictionary:(NSDictionary *)JSON forClass:(Class)className;


@end
