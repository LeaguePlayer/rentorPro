//
//  VVBaseTableViewController.h
//  rentor
//
//  Created by vegera on 30.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VVBaseTableViewController : UITableViewController

+ (NSString *)uuid;

- (void)showAlert:(NSString *)message;

@end
