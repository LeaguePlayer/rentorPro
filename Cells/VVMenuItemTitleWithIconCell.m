//
//  VVMenuItemTitleWithIconCell.m
//  rentor
//
//  Created by vegera on 10.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVMenuItemTitleWithIconCell.h"

@implementation VVMenuItemTitleWithIconCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(9, 0, 320, 44)];
        selectedView.layer.cornerRadius = 8;
        selectedView.layer.masksToBounds = YES;
        selectedView.alpha = 0.2f;
        selectedView.backgroundColor = [UIColor whiteColor];
        
        UIView* view = [[UIView alloc] init];
        [view setBackgroundColor:[UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1.f]];
        [view addSubview:selectedView];
        
        self.selectedBackgroundView =  view;
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 12, 201, 21)];
        [titleLabel setTextColor:[UIColor colorWithRed:152.f/255.f green:152.f/255.f blue:152.f/255.f alpha:1.f]];
        [titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:17.f]];
        
        UIImageView* iconImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:iconImageView];
        
        self.titleLabel = titleLabel;
        self.iconImageView = iconImageView;
        
        [self.contentView setBackgroundColor:[UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1.f]];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
