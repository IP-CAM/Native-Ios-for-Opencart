//
//  ProductCell.m
//  guru
//
//  Created by Amit on 10/7/18.
//  Copyright © 2018 Amit. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)stepperChange:(id)sender {
    
    
    self.quantity.text = [NSString stringWithFormat:@"%f",self.stepper.value];
}



@end
