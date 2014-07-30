//
//  VVCreateRealtyStepOneTableViewController.h
//  rentor
//
//  Created by vegera on 28.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVBaseTableViewController.h"

@interface VVCreateRealtyStepOneTableViewController : VVBaseTableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel* show;
@property (strong, nonatomic) IBOutlet UISwitch *rusSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *animalSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *childSwitch;
@property (strong, nonatomic) IBOutlet UITextField *costTextField;
@property (strong, nonatomic) IBOutlet UISlider *costSlider;

@property (strong, nonatomic) IBOutlet UITextView *publicCommentTextField;
@property (strong, nonatomic) IBOutlet UITextView *privateCommentTextField;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cellForChangeAccessoryCollection;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cellCheckboxCollection;

- (IBAction)actionChangeCostFromTextField:(UITextField *)sender forEvent:(UIEvent *)event;
- (IBAction)actionChangeCostFromSlider:(UISlider *)sender forEvent:(UIEvent *)event;

@end
