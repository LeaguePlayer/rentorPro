//
//  VVAdvertisingsAndClientsViewController.h
//  rentor
//
//  Created by vegera on 25.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVBaseViewController.h"
#import "VVBaseTableViewController.h"
#import "ECSlidingViewController.h"

@interface VVAdvertisingsAndClientsViewController : VVBaseViewController <UITableViewDataSource, UITableViewDelegate, ECSlidingViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *tabSegmentedControl;


@property (strong, nonatomic) IBOutlet UITableView* tableView;

- (IBAction)actionTab:(UISegmentedControl *)sender;
- (IBAction)menuButtonTapped:(id)sender;
- (IBAction)actionSetFilter:(UIBarButtonItem *)sender;

@end
