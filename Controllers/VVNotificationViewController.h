//
//  VVNotificationViewController.h
//  rentor
//
//  Created by vegera on 01.08.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVBaseViewController.h"

@interface VVNotificationViewController : VVBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView* tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tabSegmentedControl;

- (IBAction)actionTab:(UISegmentedControl *)sender;
- (IBAction)menuButtonTapped:(id)sender;

@end
