//
//  VVMainAdvTableViewCell.m
//  rentor
//
//  Created by vegera on 25.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVMainAdvTableViewCell.h"

@implementation VVMainAdvTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UILabel* countRoomLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, 6, 56, 20)];
        [countRoomLabel setTextAlignment:NSTextAlignmentCenter];
        [countRoomLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:20.5f]];
        [countRoomLabel setTextColor:[UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1.0]];
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 220, 44)];
        [titleLabel setNumberOfLines:2];
        [titleLabel setTextColor:[UIColor colorWithRed:184.f/255.f green:183.f/255.f blue:183.f/255.f alpha:1.0]];
        [titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:16.f]];
        
        UILabel* roomLabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 30, 35, 6)];
        [roomLabel setTextAlignment:NSTextAlignmentCenter];
        [roomLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:8.f]];
        [roomLabel setTextColor:[UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1.0]];
        
        UIView* viewSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, 43, 320, 1)];
        viewSeparator.alpha = 0.3f;
        viewSeparator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [viewSeparator setBackgroundColor:[UIColor blackColor]];
        
        self.countRoomLabel = countRoomLabel;
        self.titleLabel = titleLabel;
        self.roomLabel = roomLabel;
        
        [self.contentView addSubview:countRoomLabel];
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:roomLabel];
        [self.contentView addSubview:viewSeparator];
        
        [self setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconSegue.png"]]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
