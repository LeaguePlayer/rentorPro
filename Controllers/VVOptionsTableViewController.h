//
//  VVOptionsTableViewController.h
//  rentor
//
//  Created by vegera on 28.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VVOptionsTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray* optionsArray;
@property (strong, nonatomic) NSMutableDictionary* selectedOptionsDictionary;
@property (assign, nonatomic) BOOL multiSelect;
@property (strong, nonatomic) NSString* barTitle;

@end
