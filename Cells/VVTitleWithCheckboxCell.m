//
//  VVTitleWithCheckboxCell.m
//  rentor
//
//  Created by vegera on 08.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVTitleWithCheckboxCell.h"

@implementation VVTitleWithCheckboxCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.disabledImage = [UIImage imageNamed:@"switchOff"];
        self.enabledImage = [UIImage imageNamed:@"switchOn"];
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 15, 320, 13.5)];
        [titleLabel setTextColor:[UIColor colorWithRed:183.f/255.f green:183.f/255.f blue:183.f/255.f alpha:1.f]];
        [titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:13.5]];
        
        UIView* viewSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, 43, 320, 2)];
        [viewSeparator setBackgroundColor:[UIColor colorWithRed:214.f/255.f green:214.f/255.f blue:214.f/255.f alpha:1.f]];
        
        UIImageView* iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(284, 11.5, 22, 22)];
        
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:viewSeparator];
        [self.contentView addSubview:iconImageView];
        
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
