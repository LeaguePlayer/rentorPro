//
//  VVMenuItemAvatarCell.m
//  rentor
//
//  Created by vegera on 10.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVMenuItemAvatarCell.h"

@implementation VVMenuItemAvatarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView setBackgroundColor:[UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1.f]];
        
        PAImageView *avatarImageView = [[PAImageView alloc] initWithFrame:CGRectMake(11, 12, 46, 46)
                                             backgroundProgressColor:[UIColor whiteColor]
                                                       progressColor:[UIColor lightGrayColor]];
//        [self.contentView addSubview:avatarView];
        // Later
//        [avatarView setImageURL:[NSURL URLWithString:@"http://cs619519.vk.me/v619519257/1bcac/WCCuce6RCo8.jpg"]];
        
        UILabel* phoneUser = [[UILabel alloc] initWithFrame:CGRectMake(70, 9, 212, 24)];
        [phoneUser setTextColor:[UIColor whiteColor]];
        [phoneUser setFont:[UIFont fontWithName:@"Helvetica Neue" size:17.f]];
        
        UILabel* nameUser = [[UILabel alloc] initWithFrame:CGRectMake(70, 38, 202, 24)];
        [nameUser setTextColor:[UIColor colorWithRed:97.f/255.f green:222.f/255.f blue:253.f/255.f alpha:1.f]];
        [nameUser setFont:[UIFont fontWithName:@"Helvetica Neue" size:12.f]];
        
        [self.contentView addSubview:phoneUser];
        [self.contentView addSubview:nameUser];
        [self.contentView addSubview:avatarImageView];
        
        self.avatarImageView = avatarImageView;
        self.phoneUser = phoneUser;
        self.nameUser = nameUser;
        
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
