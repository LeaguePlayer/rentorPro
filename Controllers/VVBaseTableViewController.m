//
//  VVBaseTableViewController.m
//  rentor
//
//  Created by vegera on 30.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVBaseTableViewController.h"

@interface VVBaseTableViewController ()

@end

@implementation VVBaseTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // change font color for navigation bar
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                     [UIFont fontWithName:@"PT Sans" size:10], NSFontAttributeName,
                                                                     nil]];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor]; // цвет текста назад
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1.0];
}

@end
