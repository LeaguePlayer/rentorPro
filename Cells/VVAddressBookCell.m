//
//  VVAddressBookCell.m
//  Rentor
//
//  Created by vegera on 24.10.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVAddressBookCell.h"

@implementation VVAddressBookCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.disabledImage = [UIImage imageNamed:@"addressbook_disabled"];
        self.enabledImage = [UIImage imageNamed:@"addressbook_enabled"];
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(62, 10, 210, 15)];
        [titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:15.f]];
        [titleLabel setTextColor:[UIColor colorWithRed:127.f/255.f green:135.f/255.f blue:137.f/255.f alpha:1.f]];
        
        UILabel* detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(62, 28, 210, 11.5f)];
        [detailLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:10.5f]];
        [detailLabel setTextColor:[UIColor colorWithRed:159.f/255.f green:165.f/255.f blue:166.f/255.f alpha:1.f]];
        
        UIView* viewSeparator = [[UIView alloc] initWithFrame:CGRectMake(62, 45, 234, 1)];
        [viewSeparator setBackgroundColor:[UIColor colorWithRed:204.f/255.f green:204.f/255.f blue:204.f/255.f alpha:1.f]];
        
        PAImageView *avatarImageView = [[PAImageView alloc] initWithFrame:CGRectMake(15, 4, 36, 36)
                                                  backgroundProgressColor:[UIColor colorWithRed:219.f/255.f green:226.f/255.f blue:229.f/255.f alpha:1.f]
                                                            progressColor:[UIColor lightGrayColor]];
        
        UIImageView* iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(274, 13, 22, 22)];
        
        [self.contentView addSubview:viewSeparator];
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:detailLabel];
        [self.contentView addSubview:avatarImageView];
        [self.contentView addSubview:iconImageView];
        
        self.titleLabel = titleLabel;
        self.detailLabel = detailLabel;
        self.avatarImageView = avatarImageView;
        self.iconImageView = iconImageView;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end
