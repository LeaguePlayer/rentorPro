//
//  VVMenuTableViewController.h
//  rentor
//
//  Created by vegera on 31.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVBaseTableViewController.h"

@interface VVMenuTableViewController : VVBaseTableViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableViewCell *emptyCell; // 125 for iphone 5
@property (weak, nonatomic) IBOutlet UITableViewCell *userCell;

@end
