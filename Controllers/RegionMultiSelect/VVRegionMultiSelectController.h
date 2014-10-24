//
//  VVRegionMultiSelectController.h
//  Rentor
//
//  Created by vegera on 15.10.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVBaseTableViewController.h"

@interface VVRegionMultiSelectController : VVBaseTableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray* optionsArray;

@end
