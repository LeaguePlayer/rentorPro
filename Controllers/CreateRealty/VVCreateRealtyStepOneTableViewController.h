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

@property (weak, nonatomic) IBOutlet UILabel* show;
@property (weak, nonatomic) IBOutlet UILabel *expires;
@property (weak, nonatomic) IBOutlet UILabel *suite;
@property (weak, nonatomic) IBOutlet UILabel *furniture;
@property (weak, nonatomic) IBOutlet UILabel *districtLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@property (weak, nonatomic) IBOutlet UITextField *costTextField;
@property (weak, nonatomic) IBOutlet UISlider *costSlider;

@property (weak, nonatomic) IBOutlet UITextView *publicCommentTextField;
@property (weak, nonatomic) IBOutlet UITextView *privateCommentTextField;
@property (weak, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cellForChangeAccessoryCollection;
@property (weak, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cellCheckboxCollection;
@property (weak, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cellForDesabledSelectCollection;

- (IBAction)actionChangeCostFromTextField:(UITextField *)sender forEvent:(UIEvent *)event;
- (IBAction)actionChangeCostFromSlider:(UISlider *)sender forEvent:(UIEvent *)event;
- (IBAction)menuButtonTapped:(id)sender;

@end
