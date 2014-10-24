//
//  VVFilterTableViewController.h
//  rentor
//
//  Created by vegera on 29.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVBaseTableViewController.h"
#import "VVFilterModel.h"

@interface VVFilterTableViewController : VVBaseTableViewController

@property (strong, nonatomic) VVFilterModel* model;
@property (strong, nonatomic) NSString* keyForNotification;

@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *district;
@property (weak, nonatomic) IBOutlet UILabel *furniture;
@property (weak, nonatomic) IBOutlet UILabel *period;
@property (weak, nonatomic) IBOutlet UILabel *additionalOptions;


@property (weak, nonatomic) IBOutlet UITextField *costFromTextField;
@property (weak, nonatomic) IBOutlet UISlider *costFromSlider;
@property (weak, nonatomic) IBOutlet UITextField *costToTextField;
@property (weak, nonatomic) IBOutlet UISlider *costToSlider;

@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cellForChangeAccessoryCollection;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cellForDesabledSelectCollection;

- (IBAction)actionFilterCancel:(UIBarButtonItem *)sender;
- (IBAction)actionFilterApply:(UIBarButtonItem *)sender;
- (IBAction)actionChangeCostFormSlider:(UISlider *)sender;
- (IBAction)actionChangeCostFromTextField:(UITextField *)sender forEvent:(UIEvent *)event;
- (IBAction)actionChangeCostToSlider:(UISlider *)sender;
- (IBAction)actionChangeCostToTextField:(UITextField *)sender forEvent:(UIEvent *)event;

@end
