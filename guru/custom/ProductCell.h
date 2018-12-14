//
//  ProductCell.h
//  guru
//
//  Created by Amit on 10/7/18.
//  Copyright © 2018 Amit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;

@property (strong, nonatomic) IBOutlet UIButton *star1;
@property (strong, nonatomic) IBOutlet UIButton *star2;
@property (strong, nonatomic) IBOutlet UIButton *star3;
@property (strong, nonatomic) IBOutlet UIButton *star4;
@property (strong, nonatomic) IBOutlet UIButton *star5;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UIStepper *stepper;

@property (weak, nonatomic) IBOutlet UILabel *quantity;




@end

NS_ASSUME_NONNULL_END
