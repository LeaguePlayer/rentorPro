//
//  VVSwipeCell.m
//  rentor
//
//  Created by vegera on 10.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVSwipeCell.h"

@implementation VVSwipeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.disabledImage = [UIImage imageNamed:@"switchOff"];
        self.enabledImage = [UIImage imageNamed:@"switchOn"];
        
        UIButton* checkButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 48)];
//        [checkButton setBackgroundColor:[UIColor redColor]];
        
        UILabel* countRoomLabel = [[UILabel alloc] initWithFrame:CGRectMake(4 + 31, 6, 56, 20)];
        [countRoomLabel setTextAlignment:NSTextAlignmentCenter];
        [countRoomLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:20.5f]];
        [countRoomLabel setTextColor:[UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1.0]];
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60 + 31, 0, 220 - 31, 44)];
        [titleLabel setNumberOfLines:2];
        [titleLabel setTextColor:[UIColor colorWithRed:184.f/255.f green:183.f/255.f blue:183.f/255.f alpha:1.0]];
        [titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:16.f]];
        
        UILabel* roomLabel = [[UILabel alloc] initWithFrame:CGRectMake(11 + 31, 30, 35, 6)];
        [roomLabel setTextAlignment:NSTextAlignmentCenter];
        [roomLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:8.f]];
        [roomLabel setTextColor:[UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1.0]];
        
        UIImageView* iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 11.5, 22, 22)];
        
        UIImageView* segueImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconSegue.png"]];
        segueImageView.frame = CGRectMake(290, 16, 17, 17);
        
        [self.contentView addSubview:countRoomLabel];
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:roomLabel];
        [self.contentView addSubview:iconImageView];
        [self.contentView addSubview:checkButton];
        [self.contentView addSubview:segueImageView];
        
        self.countRoomLabel = countRoomLabel;
        self.titleLabel = titleLabel;
        self.roomLabel = roomLabel;
        self.iconImageView = iconImageView;
        self.checkButton = checkButton;
        
        
        [checkButton addTarget:self action:@selector(actionChecked:) forControlEvents:UIControlEventTouchUpInside];
        
        self.rightUtilityButtons = [self rightButtons];
    }
    return self;
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:214.f/255.f green:214.f/255.f blue:214.f/255.f alpha:1.f]
                                                 icon:[UIImage imageNamed:@"swipe_edit_button"]];
    
    return rightUtilityButtons;
}

- (IBAction)actionChecked:(UIButton *)button
{
    NSLog(@"actionChecked:");
    if (self.model.selected) {
        self.model.selected = NO;
        [self.iconImageView setImage:self.disabledImage];
    } else {
        self.model.selected = YES;
        [self.iconImageView setImage:self.enabledImage];
        [self.delegateController actionChecked];
    }
}

- (void)setDelegateController:(VVMainAdvViewController *)delegateController
{
    _delegateController = delegateController;
}

- (void)setModel:(VVRealty *)model
{
    _model = model;
    if (model.selected) {
        [self.iconImageView setImage:self.enabledImage];
    } else {
        [self.iconImageView setImage:self.disabledImage];
    }
    
    self.countRoomLabel.text = model.what;
    self.titleLabel.text = [NSString stringWithFormat:@"%@, %@", model.regionLabelText, model.price];
}

@end
