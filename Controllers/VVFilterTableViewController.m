//
//  VVFilterTableViewController.m
//  rentor
//
//  Created by vegera on 29.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVFilterTableViewController.h"

@interface VVFilterTableViewController ()



@end

@implementation VVFilterTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@" step TWO %i",[self.navigationController.viewControllers count]);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem* applyFilterBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(actionApplyFilters)];
    self.navigationItem.rightBarButtonItem = applyFilterBarButtonItem;
    
   
    
   
    UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMenu.frame = CGRectMake(0, 0, 22, 18);
    [btnMenu setImage:[UIImage imageNamed:@"icon_58"] forState:UIControlStateNormal];
    [btnMenu addTarget:self action:@selector(showLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationItem.leftBarButtonItem setCustomView:btnMenu];
    
    
    NSLog(@"%@", self.navigationController.navigationItem.leftBarButtonItem);
//    
////    leftBarButtonItem = rootViewController.navigationItem.leftBarButtonItem;
////
////    
//    UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnMenu.frame = CGRectMake(0, 0, 22, 18);
//    [btnMenu setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
//    [btnMenu addTarget:self action:@selector(showLeftMenu) forControlEvents:UIControlEventTouchUpInside];
//    [leftBarButtonItem setCustomView:btnMenu];
//    self.navigationController.navigationItem.leftBarButtonItem
//    
//    
//    NSLog(@"%@", self.navigationController.navigationItem.leftBarButtonItem);
    
    [self refreshAccessory];
}

- (void)closeFilterView
{
    NSLog(@"closeFilterView");
}

- (void)actionApplyFilters
{
    NSLog(@"actionApplyFilters");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}*/

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"prepareForSegue");
}

#pragma mark - Accessory

- (void)refreshAccessory
{
    for (UITableViewCell* cell in self.cellForChangeAccessoryCollection) {
        [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconSegue.png"]]];
    }
}

@end
