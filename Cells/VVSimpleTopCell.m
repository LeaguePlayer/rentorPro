//
//  VVSimpleTopCell.m
//  rentor
//
//  Created by vegera on 08.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVSimpleTopCell.h"

@implementation VVSimpleTopCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.stepOneImage = [UIImage imageNamed:@"stepOne"];
        self.stepTwoImage = [UIImage imageNamed:@"stepTwo"];
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 14, 320, 13)];
        [titleLabel setTextColor:[UIColor blackColor]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:13.f]];
        
        UIImageView* iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(135, 39, 50, 2)];
        
        UIView* viewSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, 54, 320, 2)];
        [viewSeparator setBackgroundColor:[UIColor colorWithRed:214.f/255.f green:214.f/255.f blue:214.f/255.f alpha:1.f]];
        
        [self.contentView addSubview:iconImageView];
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:viewSeparator];
        
        self.titleLabel = titleLabel;
        self.iconImageView = iconImageView;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
