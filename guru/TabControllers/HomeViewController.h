//
//  FirstViewController.h
//  guru
//
//  Created by Amit on 8/9/18.
//  Copyright © 2018 Amit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKMappingResult.h"

@interface HomeViewController : UIViewController
{
    RKMappingResult* _bestSellerResult;
    RKMappingResult* _latestProductResult;
    RKMappingResult* _featuredProductResult;


    RKMappingResult* _slideshowResult;

}

@end

