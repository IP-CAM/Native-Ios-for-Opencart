//
//  SecondViewController.m
//  guru
//
//  Created by Amit on 8/9/18.
//  Copyright © 2018 Amit. All rights reserved.
//

#import "CategoryViewController.h"
#import "OpenCartKit.h"
#import "Resource.h"
#import "ProductTableViewController.h"
#import "iSON.h"

@interface CategoryViewController () <UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CategoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.navigationController.navigationBar setBackgroundColor:UIColor.redColor];

    self.navigationItem.title = @"Categories";

    //_category = @[@"Guru Prasadam", @"Health care", @"Personal Care", @"Yog", @"Groceries & Staples", @"Beverages"];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadData{
    __weak __typeof(self)weakSelf = self;
    
    OCCategoryService* serivce = [OCCategoryService getCategories:nil];
    [serivce execute:^(id response) {
        NSArray * listt = [response objectForKey:@"data"];
        self->list = [[NSMutableArray alloc] init];
        for (int i=0; i < listt.count; i++) {
            
        [self->list addObject:[iSON objectFromDictionary:listt[i] forClass:[Category class]]];
        }
      //   = [Resource parseResponse2Result:list];
        //@step
        [weakSelf.tableView reloadData];
        
        //        [weakSelf stopPullToRefreshAnimation];
        
    } failure:^(NSError *error) {
        // [CDialogViewManager showMessageView:[error localizedDescription] message:nil delayAutoHide: 3];
        //[weakSelf stopPullToRefreshAnimation];
        
    }];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return list.count;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* sectionName;
    switch (section) {
        case 2:
            sectionName = NSLocalizedString(@"Categories", nil);
            break;
    }
    
    return sectionName;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell" forIndexPath:indexPath];
    
    NSString* title = list[indexPath.row].name;
    
    
   // cell.textLabel.text = [StringUtils decodeHTMLString:title];
    
    cell.imageView.image = [UIImage imageNamed:@"price-tag"];
    
    cell.textLabel.text = title;

    switch (indexPath.row) {
        case 1:

            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 3:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            break;

        default:
            cell.accessoryType = UITableViewCellAccessoryNone;

            break;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    ProductTableViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"ProductTableViewController"];
    vc.categoryDetail = list[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];

}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"showProduct"]) {
//        //Do something
//
//        UITableView * table = sender;
//
//       ProductTableViewController *productController = (ProductTableViewController*)segue.destinationViewController;
//
//
//        productController.categoryDetail =
//    }
//}

@end
