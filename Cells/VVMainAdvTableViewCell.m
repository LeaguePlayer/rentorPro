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
        UILabel* countRoomLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 6, 30, 20)];
        [countRoomLabel setTextAlignment:NSTextAlignmentCenter];
        [countRoomLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:25.5f]];
        [countRoomLabel setTextColor:[UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1.0]];
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 220, 44)];
        [titleLabel setNumberOfLines:2];
        [titleLabel setTextColor:[UIColor colorWithRed:184.f/255.f green:183.f/255.f blue:183.f/255.f alpha:1.0]];
        [titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:16.f]];
        
        UILabel* roomLabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 30, 35, 6)];
        [roomLabel setTextAlignment:NSTextAlignmentCenter];
        [roomLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:8.f]];
        [roomLabel setTextColor:[UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1.0]];
        
        self.countRoomLabel = countRoomLabel;
        self.titleLabel = titleLabel;
        self.roomLabel = roomLabel;
        
        [self.contentView addSubview:countRoomLabel];
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:roomLabel];
        
        [self setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconSegue.png"]]];
        
        /*
         UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 50, 300, 45)];
         titleLabel.numberOfLines = 2;
         titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0f];
         titleLabel.textColor = [UIColor whiteColor];
         //[titleLabel setText:[event name]];
         self.name = titleLabel;
         
         UILabel* detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 120, 300, 45)];
         detailLabel.numberOfLines = 4;
         detailLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
         detailLabel.textColor = [UIColor whiteColor];
         //[detailLabel setText:[event previewText]];
         self.previewText = detailLabel;
         
         
         //[self.contentView setBackgroundColor:[UIColor redColor]];
         
         UIView* labelView = [[UIView alloc] initWithFrame:CGRectMake(12, 98, 50, 5)];
         [labelView setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:169.0/255.0 blue:226.0/255.0 alpha:1.0]];
         
         UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
         
         UIView* shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
         [shadowView setBackgroundColor:[UIColor blackColor]];
         [shadowView setAlpha:0.5];
         
         UIImageView* iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
         
         //UIImage *image = [[UIImage alloc] init];
         self.previewImageView = iv;
         
         //[iv setImage:image];
         [iv addSubview:shadowView];
         [iv addSubview:labelView];
         [iv addSubview:titleLabel];
         [iv addSubview:detailLabel];
         
         [view addSubview:iv];
         
         [self.contentView addSubview:view];
         */
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
