//
//  VVCreateClientTableViewController.h
//  rentor
//
//  Created by vegera on 01.08.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVBaseTableViewController.h"

@interface VVCreateClientTableViewController : VVBaseTableViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UILabel *districtLabel;

@property (weak, nonatomic) IBOutlet UITextView *publicCommentTextField;
@property (weak, nonatomic) IBOutlet UITextView *privateCommentTextField;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cellCheckboxCollection;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cellForChangeAccessoryCollection;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cellForDesabledSelectCollection;

- (IBAction)menuButtonTapped:(id)sender;

@end
