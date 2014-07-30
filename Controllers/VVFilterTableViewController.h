//
//  VVFilterTableViewController.h
//  rentor
//
//  Created by vegera on 29.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVBaseTableViewController.h"

@interface VVFilterTableViewController : VVBaseTableViewController

@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cellForChangeAccessoryCollection;

@end
