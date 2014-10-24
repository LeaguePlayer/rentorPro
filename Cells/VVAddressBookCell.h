//
//  VVAddressBookCell.h
//  Rentor
//
//  Created by vegera on 24.10.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PAImageView.h"

@interface VVAddressBookCell : UITableViewCell

@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UILabel* detailLabel;
@property (strong, nonatomic) PAImageView* avatarImageView;
@property (strong, nonatomic) UIImageView* iconImageView;

@property (strong, nonatomic) UIImage* disabledImage;
@property (strong, nonatomic) UIImage* enabledImage;

@end
