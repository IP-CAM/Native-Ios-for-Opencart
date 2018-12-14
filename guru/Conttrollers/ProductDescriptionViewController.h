//
//  ProductDescriptionViewController.h
//  guru
//
//  Created by Amit on 10/15/18.
//  Copyright © 2018 Amit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductDescriptionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;

@property (weak, nonatomic) IBOutlet UILabel *productPrice;

@property (weak, nonatomic) IBOutlet UIWebView *productDescWebView;

@property (strong, nonatomic) IBOutlet UIButton *star1;
@property (strong, nonatomic) IBOutlet UIButton *star2;
@property (strong, nonatomic) IBOutlet UIButton *star3;
@property (strong, nonatomic) IBOutlet UIButton *star4;
@property (strong, nonatomic) IBOutlet UIButton *star5;

@property (strong, nonatomic) NSDictionary* productDetails;

@end

NS_ASSUME_NONNULL_END
