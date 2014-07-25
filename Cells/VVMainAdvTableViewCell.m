//
//  VVMainAdvTableViewCell.m
//  rentor
//
//  Created by vegera on 25.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVMainAdvTableViewCell.h"

@implementation VVMainAdvTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDictionary:(NSDictionary *)dictionary
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UILabel* countRoomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [countRoomLabel setTextAlignment:NSTextAlignmentCenter];
        [countRoomLabel setTextColor:[UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1.0]];
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [titleLabel setTextColor:[UIColor colorWithRed:184.f/255.f green:183.f/255.f blue:183.f/255.f alpha:1.0]];
        
        UILabel* roomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [roomLabel setTextAlignment:NSTextAlignmentCenter];
        [roomLabel setTextColor:[UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1.0]];
        
        [self.contentView addSubview:countRoomLabel];
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:roomLabel];
        
        self.countRoomLabel = countRoomLabel;
        self.titleLabel = titleLabel;
        self.roomLabel = roomLabel;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
