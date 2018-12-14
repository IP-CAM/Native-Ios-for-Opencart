//
//  FilterTableViewController.m
//  guru
//
//  Created by Amit on 10/15/18.
//  Copyright © 2018 Amit. All rights reserved.
//

#import "FilterTableViewController.h"

@interface FilterTableViewController ()
@property (strong,nonatomic)NSArray* filterGroups;
@property (strong,nonatomic)NSArray* filter;

@end

@implementation FilterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _filterGroups = [_filterDetails objectForKey:@"filter_groups"];
    
    UIBarButtonItem * applyFilter = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(applyFilter)];
    
    self.navigationItem.rightBarButtonItem = applyFilter;
    self.navigationItem.title = @"Filter";
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _filterGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    _filter = [_filterGroups[section] objectForKey:@"filter"];
    
    return _filter.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_filterGroups[section] objectForKey:@"name"];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"filterCell" forIndexPath:indexPath];
    _filter = [_filterGroups[indexPath.section] objectForKey:@"filter"];

    cell.textLabel.text = [_filter[indexPath.row] objectForKey:@"name"];
    
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)applyFilter
{
    [self dismissViewControllerAnimated:YES completion:^(void){
        
        // load filters
        
    }];
}

@end
