//
//  VVDetailAdvTableViewController.h
//  rentor
//
//  Created by vegera on 30.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
#import "VVBaseTableViewController.h"

@interface VVDetailAdvTableViewController : VVBaseTableViewController <UITableViewDelegate, MWPhotoBrowserDelegate>

@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cellForChangeAccessoryCollection;

@end
