//
//  VVCallCell.m
//  rentor
//
//  Created by vegera on 15.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVCallCell.h"

@implementation VVCallCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 15, 320, 13.5)];
        [titleLabel setTextColor:[UIColor colorWithRed:183.f/255.f green:183.f/255.f blue:183.f/255.f alpha:1.f]];
        [titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:13.5]];
        
        UILabel* detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, 200, 12.f)];
        [detailLabel setTextColor:[UIColor blackColor]];
        [detailLabel setTextAlignment:NSTextAlignmentRight];
        [detailLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:12.f]];
        
        UIImageView* segueImageView = [[UIImageView alloc] initWithFrame:CGRectMake(22, 14, 14, 18)];
        [segueImageView setImage:[UIImage imageNamed:@"rieltorPhoneIcon"]];
        
        UIView* separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, 320, 1)];
        [separatorView setBackgroundColor:[UIColor colorWithRed:183.f/255.f green:183.f/255.f blue:183.f/255.f alpha:1.f]];
        
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:detailLabel];
        [self.contentView addSubview:separatorView];
        [self.contentView addSubview:segueImageView];
        
        self.titleLabel = titleLabel;
        self.detailLabel = detailLabel;
        
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
