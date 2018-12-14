//
//  ProductDescriptionViewController.m
//  guru
//
//  Created by Amit on 10/15/18.
//  Copyright © 2018 Amit. All rights reserved.
//

#import "ProductDescriptionViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <NYTPhotoViewer/NYTPhotosViewController.h>
#import <NYTPhotoViewer/NYTPhotoViewerArrayDataSource.h>
#import "OCCartService.h"

@interface ProductDescriptionViewController ()<NYTPhotosViewControllerDelegate>
@property (strong, nonatomic) NSArray<UIButton *> *starButtons;
@property (nonatomic) NSInteger rating;
@property (nonatomic) NYTPhotoViewerArrayDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UILabel *quantity;


@end

@implementation ProductDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.starButtons = @[ self.star1,self.star1, self.star2, self.star3, self.star4, self.star5 ];

    self.productName.text = [self.productDetails objectForKey:@"name"];
    self.productPrice.text = [self.productDetails objectForKey:@"price_formated"];
    
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:[self.productDetails objectForKey:@"image"]]
                         placeholderImage:[UIImage imageNamed:@"new-product"]];
    
    
    [self starButtonWasTapped:self.starButtons[[[self.productDetails objectForKey:@"rating"]intValue]]];
    
    [self.productDescWebView loadHTMLString:[self.productDetails objectForKey:@"description"] baseURL:nil];
    //♥
    
    UIBarButtonItem * wishlist = [[UIBarButtonItem alloc] initWithTitle:@"♡" style:UIBarButtonItemStyleDone target:self action:@selector(addToWishlist)];
    
    self.navigationItem.rightBarButtonItem = wishlist;

}

- (void)starButtonWasTapped:(UIButton *)button {
    NSInteger buttonIndex = [self.starButtons indexOfObject:button];
    if (buttonIndex == NSNotFound) { return; }
    self.rating = buttonIndex + 1;
    
    [self.starButtons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setTitle:(idx <= buttonIndex ? @"★" : @"☆") forState:UIControlStateNormal];
    }];
    
  //  [self reloadDispatchSection];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*- (IBAction)imageButtonTapped:(id)sender {
    self.dataSource = [self.class newTimesBuildingDataSource];
    
    NYTPhotosViewController *photosViewController = [[NYTPhotosViewController alloc] initWithDataSource:self.dataSource initialPhoto:nil delegate:self];
    
    [self presentViewController:photosViewController animated:YES completion:nil];
    
    [self updateImagesOnPhotosViewController:photosViewController afterDelayWithDataSource:self.dataSource];
    BOOL demonstrateDataSourceSwitchAfterTenSeconds = NO;
    if (demonstrateDataSourceSwitchAfterTenSeconds) {
        [self switchDataSourceOnPhotosViewController:photosViewController afterDelayWithDataSource:self.dataSource];
    }
}*/

// This method simulates a previously blank photo loading its images after 5 seconds.
/*- (void)updateImagesOnPhotosViewController:(NYTPhotosViewController *)photosViewController afterDelayWithDataSource:(NYTPhotoViewerArrayDataSource *)dataSource {
    if (dataSource != self.dataSource) {
        return;
    }
    
    CGFloat updateImageDelay = 5.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(updateImageDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (NYTExamplePhoto *photo in dataSource.photos) {
            if (!photo.image && !photo.imageData) {
                photo.image = [UIImage imageNamed:@"NYTimesBuilding"];
                photo.attributedCaptionSummary = [[NSAttributedString alloc] initWithString:@"Photo which previously had a loading spinner (to see the spinner, reopen the photo viewer and scroll to this photo)" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody]}];
                [photosViewController updatePhoto:photo];
            }
        }
    });
}*/

// This method simulates completely swapping out the data source, after 10 seconds.


- (void)addToWishlist
{
    // adding to wishlist if logged in
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UINavigationController * vc = [storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
    
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (IBAction)stepChange:(id)sender {
    
    //♡
    UIStepper * stepper = sender;
    double value = stepper.value;
    
    [self.quantity setText:[NSString stringWithFormat:@"%d", (int)value]];
    
    
}
- (IBAction)addToCart:(id)sender {
    
        __weak __typeof(self)weakSelf = self;
        
        OCCartService * serivce = [OCCartService add:[self.productDetails objectForKey:@"product_id"] quantity:self.quantity.text];
        [serivce execute:^(id response) {
            NSLog(@"session already logged in");
            
           // NSDictionary* item = [[Resource parseResponse2Result:[response objectForKey:@"data"]] dictionary];
            
           // [Resource storeUserAccountInfo:item];
            // if logged in user will have data and give success
            
            //@step
           // [weakSelf.tableView reloadData];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notification"
                                                                           message:@"Product added to cart"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *goToCart = [UIAlertAction actionWithTitle:@"Go to cart"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action)
                                 {
                                     self.tabBarController.selectedIndex = 2;

                                     [self.navigationController popToRootViewControllerAnimated:YES];
                                     
                                 }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action)
                                 {
                                     [self dismissViewControllerAnimated:YES completion:nil];
                                 }];
            
            [alert addAction:goToCart];
            [alert addAction:cancel];

            [self presentViewController:alert animated:YES completion:nil];
            
        } failure:^(NSError *error) {
            
            NSLog(@"session not logged in");
            
        }];
    
}
- (IBAction)buyNow:(id)sender {
    
    
}

@end
