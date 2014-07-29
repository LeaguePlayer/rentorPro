//
//  VVAdvertisingsAndClientsViewController.h
//  rentor
//
//  Created by vegera on 25.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVBaseViewController.h"

@interface VVAdvertisingsAndClientsViewController : VVBaseViewController <UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView* tableView;

- (IBAction)actionTab:(UISegmentedControl *)sender;

@end
