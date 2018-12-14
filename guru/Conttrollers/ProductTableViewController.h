//
//  ProductViewController.h
//  guru
//
//  Created by Amit on 10/5/18.
//  Copyright © 2018 Amit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKMappingResult.h"
#import "Category.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductTableViewController : UITableViewController
{
    RKMappingResult* _productDescription;    
}

@property (nonatomic,strong) Category* categoryDetail;

- (void)reloadProductByFilter;

@end

NS_ASSUME_NONNULL_END
