//
//  VVOptionsTableViewCell.m
//  rentor
//
//  Created by vegera on 29.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVOptionsTableViewCell.h"

@implementation VVOptionsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UILabel* detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 15, 238, 15)];
        [detailLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:13.f]];
        [detailLabel setTextColor:[UIColor colorWithRed:183.f/255.f green:183.f/255.f blue:183.f/255.f alpha:1.f]];
        self.titleLabel = detailLabel;
        
        [self.contentView addSubview:detailLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
