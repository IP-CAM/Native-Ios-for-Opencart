//
//  AccountViewController.m
//  guru
//
//  Created by Amit on 8/12/18.
//  Copyright © 2018 Amit. All rights reserved.
//

#import "AccountViewController.h"
#import "OCAccountService.h"
#import "Resource.h"

@interface AccountViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationController.navigationBar.translucent = true;
    self.navigationItem.title = @"Account";
    
    [self getAccountInfo];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getAccountInfo{
    __weak __typeof(self)weakSelf = self;
    
    OCAccountService * serivce = [OCAccountService getAccountInfo];
    [serivce execute:^(id response) {
        NSLog(@"session already logged in");

        NSDictionary* item = [[Resource parseResponse2Result:[response objectForKey:@"data"]] dictionary];
        
        [Resource storeUserAccountInfo:item];
        // if logged in user will have data and give success
        
        //@step
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
        
        // if not logged in user will have data and give success

        NSLog(@"session not logged in");
        
        // [CDialogViewManager showMessageView:[error localizedDescription] message:nil delayAutoHide: 3];
        //[weakSelf stopPullToRefreshAnimation];
        
    }];
}
#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return  1;
            break;
        case 1:
            return  4;
            break;
            
        case 2:
            return  1;
            break;
            
        default:
            return  1;
            break;
    }
}

//- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSString* sectionName = @"";
//    switch (section) {
//        case 2:
//            sectionName = NSLocalizedString(@"Settings", nil);
//            break;
//    }
//
//    return sectionName;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 90;
    
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"accountCell" forIndexPath:indexPath];
    
    
    switch (indexPath.section) {
        case 0: {
            
            NSDictionary* userData = [Resource loadUserAccountInfo];
            
            if (userData != nil) {
                cell.textLabel.text =[NSString stringWithFormat:@"%@ %@", [userData objectForKey:@"firstname"],[userData objectForKey:@"lastname"]];
                cell.detailTextLabel.text = [userData objectForKey:@"email"];

            }else {
                cell.textLabel.text = @"Sign In";
                cell.detailTextLabel.text = @"View your orders, wishlist, etc";

            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = [UIImage imageNamed:@"account"];

            break;
        }
        case 1:{
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Order History";
                    cell.detailTextLabel.text = @"";

                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

                    break;
                case 1:
                    cell.textLabel.text = @"Transactions";
                    cell.detailTextLabel.text = @"";

                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    
                    break;
                case 2:
                    cell.textLabel.text = @"Downloads";
                    cell.detailTextLabel.text = @"";
                    
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    
                    break;
                case 3:
                    cell.textLabel.text = @"My Wishlist";
                    cell.detailTextLabel.text = @"";
                    
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    
                    break;
                    
                default:
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                    break;
            }
            
        }
            
            break;
            
        default:
            cell.textLabel.text = @"Clear History";
            cell.detailTextLabel.text = @"";

            cell.accessoryType = UITableViewCellAccessoryNone;
            
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
