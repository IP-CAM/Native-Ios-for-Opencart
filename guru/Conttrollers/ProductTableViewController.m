//
//  ProductViewController.m
//  guru
//
//  Created by Amit on 10/5/18.
//  Copyright © 2018 Amit. All rights reserved.
//

#import "ProductTableViewController.h"
#import "OpenCartKit.h"
#import "Resource.h"
#import "ProductCell.h"
#import <FSPagerView/FSPagerView-Swift.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "ProductDescriptionViewController.h"
#import "FilterTableViewController.h"


@interface ProductTableViewController ()
@property (strong, nonatomic) NSArray<UIButton *> *starButtons;

@property (nonatomic) NSInteger rating;

@end

@implementation ProductTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.categoryDetail.name;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"filter" style:UIBarButtonItemStyleDone target:self action:@selector(loadFilerController)];
    [self loadProductListById];

}

- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

- (void)loadProductListById{
    __weak __typeof(self)weakSelf = self;
    
    OCProductService * serivce = [OCProductService getProudctsByCategoryId:[NSString stringWithFormat:@"%@",self.categoryDetail.category_id]];
    [serivce execute:^(id response) {
        NSArray* list = [response objectForKey:@"data"];
        
        self->_productDescription = [Resource parseResponse2Result:list];
        //@step
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
        // [CDialogViewManager showMessageView:[error localizedDescription] message:nil delayAutoHide: 3];
        //[weakSelf stopPullToRefreshAnimation];
        
    }];
}

- (void)starButtonWasTapped:(UIButton *)button {
    NSInteger buttonIndex = [self.starButtons indexOfObject:button];
    if (buttonIndex == NSNotFound) { return; }
    self.rating = buttonIndex + 1;
    
    [self.starButtons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setTitle:(idx <= buttonIndex ? @"★" : @"☆") forState:UIControlStateNormal];
    }];
    
    [self reloadDispatchSection];
}
#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _productDescription.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
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
    
    return 90;
}

- (void)reloadDispatchSection {
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productCell" forIndexPath:indexPath];
    
    self.starButtons = @[ cell.star1,cell.star1, cell.star2, cell.star3, cell.star4, cell.star5 ];

    
    NSArray* items = [_productDescription array];
    NSUInteger row = indexPath.row;
    NSDictionary* item = [items objectAtIndex:row];
    NSString* title = [item valueForKey:@"name"];
    NSString* imageUrlString = [item valueForKey:@"image"];
    // cell.textLabel.text = title;
    int index = [[item valueForKey:@"rating"]intValue];
    [self starButtonWasTapped:self.starButtons[index]];
    [cell.productImage sd_setImageWithURL:[NSURL URLWithString:imageUrlString]
                      placeholderImage:[UIImage imageNamed:@"new-product"]];
    
    cell.separatorInset = UIEdgeInsetsMake(20, 20, 20, 20);
    cell.layer.borderWidth = 5;
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.productName.text = title;
    cell.price.text = [item valueForKey:@"price_formated"];
    cell.productImage.layer.cornerRadius = 8;
    cell.productImage.layer.masksToBounds = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    ProductDescriptionViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"ProductDescriptionViewController"];
   // vc.categoryDetail = list[indexPath.row];
    NSArray* items = [_productDescription array];
    NSUInteger row = indexPath.row;
    NSDictionary* item = [items objectAtIndex:row];
    vc.productDetails = item;
    
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loadFilerController
{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    FilterTableViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"FilterTableViewController"];
    
    vc.filterDetails = self.categoryDetail.filters;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)reloadProductByFilter
{
    __weak __typeof(self)weakSelf = self;
    
    OCProductService * serivce = [OCProductService getProudctsByCategoryId:[NSString stringWithFormat:@"%@",self.categoryDetail.category_id] filter:@"1"];
    [serivce execute:^(id response) {
        NSArray* list = [response objectForKey:@"data"];
        
        self->_productDescription = [Resource parseResponse2Result:list];
        //@step
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
        // [CDialogViewManager showMessageView:[error localizedDescription] message:nil delayAutoHide: 3];
        //[weakSelf stopPullToRefreshAnimation];
        
    }];
}

@end
