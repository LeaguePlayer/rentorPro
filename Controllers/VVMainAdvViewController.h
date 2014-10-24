//
//  VVMainAdvViewController.h
//  rentor
//
//  Created by vegera on 30.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVBaseTableViewController.h"
#import "SWTableViewCell.h"

@interface VVMainAdvViewController : VVBaseTableViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, SWTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *tabSegmentedControl;

- (IBAction)actionTab:(UISegmentedControl *)sender;
- (IBAction)actionEditTableCell:(UIBarButtonItem *)sender;

- (void)actionChecked;

@end
