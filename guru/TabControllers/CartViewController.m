//
//  CartViewController.m
//  guru
//
//  Created by Amit on 8/12/18.
//  Copyright © 2018 Amit. All rights reserved.
//

#import "CartViewController.h"
#import "OCCartService.h"
#import "Resource.h"
#import "ProductCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface CartViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"My cart";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidLoad];
    
    [self getCartData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getCartData {
    __weak __typeof(self)weakSelf = self;
    
    OCCartService * serivce = [OCCartService getProducts];
    [serivce execute:^(id response) {
        NSLog(@"products in cart");
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
        self.editButtonItem.target = self;
        self.editButtonItem.action = @selector(editingToggel);
        

        
       // self.tableView.editing = YES;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Checkout" style:UIBarButtonItemStyleDone target:self action:@selector(proceedToCheckout)];
        // NSDictionary* item = [[Resource parseResponse2Result:[response objectForKey:@"data"]] dictionary];
        
        NSDictionary* list = [response objectForKey:@"data"];
        
        self->_cartResult = [Resource parseResponse2Result:list];
        
        [[self navigationController] tabBarItem].badgeValue = [NSString stringWithFormat:@"%d",[[[_cartResult dictionary] objectForKey:@"products"] count]];

        //@step
        [weakSelf.tableView reloadData];
        
        // [Resource storeUserAccountInfo:item];
        // if logged in user will have data and give success
        
        //@step
        // [weakSelf.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"no product in cart");
        
        self.tableView.hidden = YES;
        
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[_cartResult dictionary] objectForKey:@"products"] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [_filterGroups[section] objectForKey:@"name"];
//
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cartCell" forIndexPath:indexPath];
    NSArray* items = [[_cartResult dictionary] objectForKey:@"products"];
   
    
    
    
    
    NSDictionary* item = [items objectAtIndex:indexPath.section];
    cell.productName.text = [item objectForKey:@"name"];
    cell.price.text = [item objectForKey:@"total"];
    cell.stepper.value = [[item objectForKey:@"quantity"] floatValue];
    cell.quantity.text = [item objectForKey:@"quantity"];
    [cell.productImage sd_setImageWithURL:[NSURL URLWithString:[item objectForKey:@"thumb"]]
                      placeholderImage:[UIImage imageNamed:@"new-product"]];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath
{
    
}
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }



 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }


- (void)proceedToCheckout {
    
}

- (void)editingToggel {
    if (self.tableView.editing) {
        self.tableView.editing = NO;
    }else {
        self.tableView.editing = YES;
    }
}
@end
