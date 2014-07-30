//
//  VVMenuViewController.h
//  rentor
//
//  Created by A-Mobile LLC on 24.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVBaseTableViewController.h"

@interface VVMenuViewController : UIViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView* tableView;

@end
