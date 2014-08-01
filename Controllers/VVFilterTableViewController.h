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

@property (weak, nonatomic) IBOutlet UITextField *costFromTextField;
@property (weak, nonatomic) IBOutlet UITextField *costToTextField;

@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cellForChangeAccessoryCollection;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cellForDesabledSelectCollection;

- (IBAction)actionFilterCancel:(UIBarButtonItem *)sender;
- (IBAction)actionFilterApply:(UIBarButtonItem *)sender;
- (IBAction)actionChangeCostFormSlider:(UISlider *)sender;
- (IBAction)actionChangeCostToSlider:(UISlider *)sender;

@end
