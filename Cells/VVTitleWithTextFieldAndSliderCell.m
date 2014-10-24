//
//  VVTitleWithTextFieldAndSliderCell.m
//  rentor
//
//  Created by vegera on 08.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVTitleWithTextFieldAndSliderCell.h"

@implementation VVTitleWithTextFieldAndSliderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 32, 200, 20)];
        [titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:13.f]];
        [titleLabel setTextColor:[UIColor colorWithRed:183.f/255.f green:183.f/255.f blue:183.f/255.f alpha:1.f]];
        
        UITextField* costTextField = [[UITextField alloc] initWithFrame:CGRectMake(180, 19, 117, 44)];
        [costTextField setBackgroundColor:[UIColor whiteColor]];
        [costTextField setBorderStyle:UITextBorderStyleRoundedRect];
        [costTextField setTextColor:[UIColor blackColor]];
        [costTextField setKeyboardType:UIKeyboardTypeNumberPad];
        [costTextField addTarget:self action:@selector(actionChangeTextField:) forControlEvents:UIControlEventEditingChanged];
        
        UISlider* slider = [[UISlider alloc] initWithFrame:CGRectMake(18, 67, 284, 31)];
        [slider setMinimumValue:1];
        [slider setMaximumValue:100000];
        [slider addTarget:self action:@selector(actionChangeCostSlider:) forControlEvents:UIControlEventValueChanged];
        
        UIView* viewSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, 111-2, 320, 2)];
        [viewSeparator setBackgroundColor:[UIColor colorWithRed:214.f/255.f green:214.f/255.f blue:214.f/255.f alpha:1.f]];
        
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:costTextField];
        [self.contentView addSubview:slider];
        [self.contentView addSubview:viewSeparator];
        
        self.titleLabel = titleLabel;
        self.costTextField = costTextField;
        self.slider = slider;
        
        [self.contentView setBackgroundColor:[UIColor colorWithRed:236.f/255.f green:241.f/255.f blue:243.f/255.f alpha:1.f]];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setModel:(VVRealty *)model
{
    _model = model;
    
    self.costTextField.text = model.price;
    [self.slider setValue:[model.price floatValue] animated:YES];
}

- (IBAction)actionChangeTextField:(UITextField *)sender
{
    NSLog(@"actionChangeTextField: %@", sender.text);
    self.model.price = self.costTextField.text;
    
    [self.slider setValue:[sender.text floatValue] animated:YES];
}

- (IBAction)actionChangeCostSlider:(UISlider *)sender {
    NSLog(@"actionChangeCostSlider");
    self.model.price = [NSString stringWithFormat:@"%d", (int)sender.value];
    self.costTextField.text = [NSString stringWithFormat:@"%d", (int)sender.value];
//    self.model.price =
//    self.costTextField.text = [NSString stringWithFormat:@"%d", (int)sender.value];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
