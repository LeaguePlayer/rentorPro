//
//  VVMenuItemAvatarCell.h
//  rentor
//
//  Created by vegera on 10.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PAImageView.h"

@interface VVMenuItemAvatarCell : UITableViewCell

@property (strong, nonatomic) PAImageView* avatarImageView;
@property (strong, nonatomic) UILabel* phoneUser;
@property (strong, nonatomic) UILabel* nameUser;

@end
