//
//  VVOptionMultiselectController.h
//  rentor
//
//  Created by vegera on 09.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVBaseTableViewController.h"

@interface VVOptionMultiselectController : VVBaseTableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray* optionsArray;

@end
