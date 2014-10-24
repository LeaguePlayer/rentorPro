//
//  VVMenuItemSpaceCell.m
//  rentor
//
//  Created by vegera on 10.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVMenuItemSpaceCell.h"

@implementation VVMenuItemSpaceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView setBackgroundColor:[UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1.f]];
        
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
