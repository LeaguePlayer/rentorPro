//
//  VVPhotoCollectionCell.m
//  rentor
//
//  Created by vegera on 09.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVPhotoCollectionCell.h"

@implementation VVPhotoCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView* photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5f, 11.5f, 83, 83)];
        
        UIImageView* closeButton = [[UIImageView alloc] initWithFrame:CGRectMake((11.5f + 83) - 11, 11.5f - 11, 22, 22)];
        [closeButton setImage:[UIImage imageNamed:@"close_button"]];
        
        
        [self.contentView addSubview:photoImageView];
        [self.contentView addSubview:closeButton];
        
        self.photoImageView = photoImageView;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
