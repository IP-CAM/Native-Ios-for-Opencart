//
//  SignUpViewController.m
//  guru
//
//  Created by Amit on 10/13/18.
//  Copyright © 2018 Amit. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem.enabled = false;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 12;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* sectionName = @"";
    
    switch (section) {
        case 0:
            sectionName = NSLocalizedString(@"First Name*", nil);
            break;
        case 1:
            sectionName = NSLocalizedString(@"Last Name*", nil);

            break;
            
        case 2:
            sectionName = NSLocalizedString(@"Email*", nil);

            break;
        case 3:
            sectionName = NSLocalizedString(@"Telephone*", nil);
            break;
        case 4:
            sectionName = NSLocalizedString(@"Address*", nil);
            
            break;
            
        case 5:
            sectionName = NSLocalizedString(@"City*", nil);
            
            break;
        case 6:
            sectionName = NSLocalizedString(@"Country*", nil);
            break;
        case 7:
            sectionName = NSLocalizedString(@"Region/State*", nil);
            
            break;
            
        case 8:
            sectionName = NSLocalizedString(@"Password*", nil);
            
            break;
        case 9:
            sectionName = NSLocalizedString(@"Confirm Password*", nil);
            break;
//        case 10:
//            sectionName = NSLocalizedString(@"Newsletter", nil);
//
//            break;
            
        case 11:
            sectionName = NSLocalizedString(@"", nil);
            
            break;
            
        default:
            break;
    }

    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:sectionName];
    
    //  NSMutableAttributedString *asterix = [[NSMutableAttributedString alloc] initWithString:@"*"];
    
    NSRange range = [sectionName rangeOfString:@"*" options:NSCaseInsensitiveSearch];
    
    [string setAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} range:range];
    
    
    //cell.textLabel.attributedText = string;
    return string.string;
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"signUpCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
  //  [cell.contentView ];
    
    switch (indexPath.section) {
        case 6:{
            cell.textLabel.text = @"Country";
            
            cell.detailTextLabel.text = @"choose your country from the list";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 7:
            
            cell.textLabel.text = @"State";
            cell.detailTextLabel.text = @"choose your state from the list";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            break;
            
        case 10:{
            cell.textLabel.text = @"Newsletter";
            cell.detailTextLabel.text = @"tap to get newsletter feeds.";
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [[cell.contentView viewWithTag:indexPath.section ] removeFromSuperview] ;


        }
            break;
        case 11:{
            cell.textLabel.text = @"I have read and agree to the Privacy Policy";
            cell.detailTextLabel.text = @"Tap to accept the policy";
            cell.accessoryType = UITableViewCellAccessoryCheckmark;

        }
            break;
        default: {
            cell.backgroundColor = UIColor.clearColor;
            UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, cell.frame.size.width - 20, cell.frame.size.height)];
            
            textField.borderStyle = UITextBorderStyleRoundedRect;
            
            textField.tag = indexPath.section;
            
                switch (indexPath.section) {
                    case 0:
                        textField.placeholder = @"First Name";

                        break;
                    case 1:
                        textField.placeholder = @"Last Name";

                        break;
                    case 2:
                        textField.placeholder = @"Email";

                        break;
                    case 3:
                        textField.placeholder = @"Telephone";

                        break;
                        
                    case 4:
                        textField.placeholder = @"Address";
                        
                        break;
                    case 5:
                        textField.placeholder = @"City";
                        
                        break;
                    case 8:
                        textField.placeholder = @"Password";
                        
                        break;
                    case 9:
                        textField.placeholder = @"Confirm Password";
                        
                        break;
                        
                    default:
                        
                        
                        break;
                }
            
            [cell.contentView addSubview:textField];
        }
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
