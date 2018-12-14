//
//  FirstViewController.m
//  guru
//
//  Created by Amit on 8/9/18.
//  Copyright © 2018 Amit. All rights reserved.
//

#import "HomeViewController.h"
#import "guru-Swift.h"
#import "OpenCartKit.h"
#import "Resource.h"
@import FSPagerView;
#import "ProductCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "iSON.h"
#import "Product.h"

@interface HomeViewController () <UITableViewDelegate,UITableViewDataSource,FSPagerViewDataSource ,FSPagerViewDelegate>

@property (weak  , nonatomic) IBOutlet FSPagerView *pagerView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //[self.tableView registerNib:[UINib nibWithNibName:@"ProcuctCell" bundle:nil] forCellReuseIdentifier:@"procuctCell"];
    
    self.pagerView.itemSize = CGSizeMake(self.pagerView.frame.size.width - 0,self.pagerView.frame.size.height ); // Fill parent
    self.pagerView.interitemSpacing = 0.0f;
    self.pagerView.isInfinite = true;
    self.pagerView.automaticSlidingInterval = 2;
    //self.pagerView.scrollDirection = FSPagerViewScrollDirectionVertical;
    self.pagerView.delegate = self;
    self.pagerView.dataSource = self;
    self.pagerView.tag = 9999;
    
    [self.pagerView registerClass:[FSPagerViewCell class] forCellWithReuseIdentifier:@"cell"];

    
    
    [self loadSlideshow];
    
    [self loadBestSeller];
    
    [self loadLatestProduct];
    
    [self loadFeaturedProduct];
    
   // [self loadProductData];
    
    UIImage *img = [UIImage imageNamed:@"logo.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
    [imgView setImage:img];
    // setContent mode aspect fit
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = imgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)loadProductData{
//    __weak __typeof(self)weakSelf = self;
//
//    OCProductService* serivce = [OCProductService getProudctsByCategoryId:@"59"];
//    [serivce execute:^(id response) {
//        NSArray* list = [response objectForKey:@"data"];
//
//       // self->_mappingResult = [Resource parseResponse2Result:list];
//        //@step
//        [weakSelf.tableView reloadData];
//
////        iCarousel *carousel = [[iCarousel alloc] initWithFrame:self.slideView.bounds];
////        carousel.delegate = self;
////        carousel.dataSource = self;
////        carousel.type = iCarouselTypeCoverFlow;
////
////        [_slideView addSubview:carousel];
//
//    } failure:^(NSError *error) {
//        // [CDialogViewManager showMessageView:[error localizedDescription] message:nil delayAutoHide: 3];
//        //[weakSelf stopPullToRefreshAnimation];
//
//    }];
//}

- (void)loadSlideshow{
    __weak __typeof(self)weakSelf = self;
    
    OCSlideshowService * serivce = [OCSlideshowService getSlideshow];
    [serivce execute:^(id response) {
        NSArray* list = [response objectForKey:@"data"];
        
        self->_slideshowResult = [Resource parseResponse2Result:list];
        //@step
        [weakSelf.pagerView reloadData];
        

        
    } failure:^(NSError *error) {
        // [CDialogViewManager showMessageView:[error localizedDescription] message:nil delayAutoHide: 3];
        //[weakSelf stopPullToRefreshAnimation];
        
    }];
}

- (void)loadBestSeller{
    __weak __typeof(self)weakSelf = self;
    
    OCProductService * serivce = [OCProductService getBestSeller];
    [serivce execute:^(id response) {
        NSArray* list = [response objectForKey:@"data"];
        
        self->_bestSellerResult = [Resource parseResponse2Result:list];
        //@step
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
        // [CDialogViewManager showMessageView:[error localizedDescription] message:nil delayAutoHide: 3];
        //[weakSelf stopPullToRefreshAnimation];
        
    }];
}

- (void)loadLatestProduct{
    __weak __typeof(self)weakSelf = self;
    
    OCProductService * serivce = [OCProductService getLatestproduct];
    [serivce execute:^(id response) {
        NSArray* list = [response objectForKey:@"data"];
        
        self->_latestProductResult = [Resource parseResponse2Result:list];
        //@step
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
        // [CDialogViewManager showMessageView:[error localizedDescription] message:nil delayAutoHide: 3];
        //[weakSelf stopPullToRefreshAnimation];
        
    }];
}

- (void)loadFeaturedProduct{
    __weak __typeof(self)weakSelf = self;
    
    OCProductService * serivce = [OCProductService getFeaturedproduct];
    [serivce execute:^(id response) {
        NSArray* list = [response objectForKey:@"data"];
        
        self->_featuredProductResult = [Resource parseResponse2Result:list];
        //@step
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
        // [CDialogViewManager showMessageView:[error localizedDescription] message:nil delayAutoHide: 3];
        //[weakSelf stopPullToRefreshAnimation];
        
    }];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"Best Seller";
    }
    else if(section == 1)
    {
        return @"Latest Product";
    }
    else
    {
        return @"Featured Product";
    }
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
        /*switch (indexPath.section) {
            case 0:
                return 55;
                break;
                
            case 1:
                return 87;
                break;
                
            default:
                break;
        }*/
    
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productCell1" forIndexPath:indexPath];
//
//
//
//
//    NSArray* items = [_mappingResult array];
//    NSUInteger row = indexPath.row;
//    NSDictionary* item = [items objectAtIndex:row];
//    NSString* title = [item valueForKey:@"name"];
//
//    cell.separatorInset = UIEdgeInsetsMake(20, 20, 20, 20);
//    cell.layer.borderWidth = 5;
//    cell.layer.borderColor = [UIColor whiteColor].CGColor;
//    cell.productName.text = title;
//    cell.productImage.layer.cornerRadius = cell.productImage.frame.size.width/2;
//    cell.imageView.layer.masksToBounds = YES;
//
//    cell.productImage.image = [UIImage imageNamed:@"new-product"];
//
//    [cell.productImage sd_setImageWithURL:[NSURL URLWithString:[item valueForKey:@"image"]]
//                 placeholderImage:[UIImage imageNamed:@"new-product"]];
//
//
//    cell.contentView.layer.cornerRadius = 8;
//
//    cell.contentView.layer.borderWidth = 1;
//    cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    cell.contentView.layer.masksToBounds = YES;
    
    
    FSPagerView* pagerViewForCell = [[FSPagerView alloc] initWithFrame:cell.bounds];
    
    pagerViewForCell.itemSize = CGSizeMake(160,pagerViewForCell.frame.size.height ); // Fill parent
    pagerViewForCell.interitemSpacing = 20.0f;
    pagerViewForCell.isInfinite = true;
    //pagerViewForCell.automaticSlidingInterval = 2;
    pagerViewForCell.delegate = self;
    pagerViewForCell.dataSource = self;
    
    [pagerViewForCell registerClass:[FSPagerViewCell class] forCellWithReuseIdentifier:@"cell"];
    pagerViewForCell.tag = indexPath.section;

    
    [cell.contentView addSubview:pagerViewForCell];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark - FSPagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(FSPagerView *)pagerView
{
    
    NSArray * item;

    switch (pagerView.tag) {
        case 0:
            return _bestSellerResult.count;

            break;
        case 1:
            return _latestProductResult.count;
            
            break;
        case 2:
            return _featuredProductResult.count;
            
            break;
        default:
            break;
    }
    
    if (pagerView.tag == 9999) {
        item = [[_slideshowResult firstObject] objectForKey:@"banners"];

    }
    
    return item.count;
}

- (FSPagerViewCell *)pagerView:(FSPagerView *)pagerView cellForItemAtIndex:(NSInteger)index
{
    FSPagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cell" atIndex:index];
    cell.backgroundColor = UIColor.whiteColor;
    
   // cell.imageView.frame = CGRectMake(0, 0, 50, 50);
    
    //cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    cell.imageView.clipsToBounds = YES;
    
    switch (pagerView.tag) {
        case 9999:{
            NSArray* items = [[_slideshowResult firstObject] objectForKey:@"banners"];
            NSUInteger row = index;
            NSDictionary* item = [items objectAtIndex:row];
            NSString* title = [item valueForKey:@"name"];
            NSString* imageUrlString = [item valueForKey:@"image"];
           // cell.textLabel.text = title;
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString]
                              placeholderImage:[UIImage imageNamed:@"new-product"]];
            break;
        }
        case 0:{
            NSArray* items = [_bestSellerResult array];
            NSUInteger row = index;
            NSDictionary* item = [items objectAtIndex:row];
            NSString* title = [NSString stringWithFormat:@"%@",[item valueForKey:@"name"]];
            NSString* imageUrlString = [item valueForKey:@"thumb"];
            cell.textLabel.text = title;
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString]
                              placeholderImage:[UIImage imageNamed:@"new-product"]];
            cell.imageView.contentMode = UIViewContentModeScaleAspectFit;


            break;
        }
        case 1:{
            NSArray* items = [_latestProductResult array];
            NSUInteger row = index;
            NSDictionary* item = [items objectAtIndex:row];
            NSString* title = [item valueForKey:@"name"];
            NSString* imageUrlString = [item valueForKey:@"thumb"];
            
            cell.textLabel.text = title;
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString]
                              placeholderImage:[UIImage imageNamed:@"new-product"]];
            cell.imageView.contentMode = UIViewContentModeScaleAspectFit;

            break;
        }
        case 2:{
            NSArray* items = [_featuredProductResult array];
            NSUInteger row = index;
            NSDictionary* item = [items objectAtIndex:row];
            NSString* title = [item valueForKey:@"name"];
            NSString* imageUrlString = [item valueForKey:@"thumb"];
            
            cell.textLabel.text = title;
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString]
                              placeholderImage:[UIImage imageNamed:@"new-product"]];
            cell.imageView.contentMode = UIViewContentModeScaleAspectFit;

            break;
        }
        default:
            break;
    }
    

    return cell;
}

#pragma mark - FSPagerViewDelegate

- (void)pagerViewDidScroll:(FSPagerView *)pagerView
{
//    if (self.pageControl.currentPage != pagerView.currentIndex) {
//        self.pageControl.currentPage = pagerView.currentIndex;
//    }
}

- (void)pagerView:(FSPagerView *)pagerView didSelectItemAtIndex:(NSInteger)index
{
    [pagerView deselectItemAtIndex:index animated:YES];
    [pagerView scrollToItemAtIndex:index animated:YES];
}

//#pragma mark iCarousel methods
//
//- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
//{
//    //return the total number of items in the carousel
//    return _mappingResult.count;
//}

//- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
//{
//    UILabel *label = nil;
//    UIImageView* productImage = nil;
//
//
//    //create new view if no view is available for recycling
//    if (view == nil)
//    {
//        //don't do anything specific to the index within
//        //this `if (view == nil) {...}` statement because the view will be
//        //recycled and used with other index values later
//        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.slideView.frame.size.width/2 + 20,self.slideView.frame.size.height)];
//
//
//       // view = [[UIView alloc] initWithFrame:self.slideView.bounds];
//
//        productImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 40)];
//        productImage.contentMode = UIViewContentModeScaleToFill;
//
//
//
//
//        //((UIImageView *)view).image = [UIImage imageNamed:@"11.jpg"];
//        view.contentMode = UIViewContentModeCenter;
//       // view.backgroundColor = UIColor.lightGrayColor;
//        view.layer.cornerRadius = 4;
//        view.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        view.layer.borderWidth = 1;
//
//
//
//        label = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 40 , view.frame.size.width, 40)];
//
//
//       // label.backgroundColor = [UIColor blueColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [label.font fontWithSize:14];
//        label.tag = 1;
//        [view addSubview:productImage];
//        [view addSubview:label];
//    }
//    else
//    {
//        //get a reference to the label in the recycled view
//        label = (UILabel *)[view viewWithTag:1];
//    }
//
//    //set item label
//    //remember to always set any properties of your carousel item
//    //views outside of the `if (view == nil) {...}` check otherwise
//    //you'll get weird issues with carousel item content appearing
//    //in the wrong place in the carousel
//
//
//
//    NSArray* items = [_mappingResult array];
//    NSUInteger row = index;
//    NSDictionary* item = [items objectAtIndex:row];
//    NSString* title = [item valueForKey:@"name"];
//    label.text = title;
//    [productImage sd_setImageWithURL:[NSURL URLWithString:[item valueForKey:@"image"]]
//                    placeholderImage:[UIImage imageNamed:@"new-product"]];
//
//
//    return view;
//}
//
//- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
//{
//    if (option == iCarouselOptionSpacing)
//    {
//        return value * 1.1;
//    }
//    return value;
//}
@end
