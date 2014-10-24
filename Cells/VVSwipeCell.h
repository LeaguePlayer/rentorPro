//
//  VVSwipeCell.h
//  rentor
//
//  Created by vegera on 10.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "SWTableViewCell.h"
#import "VVRealty.h"
#import "VVMainAdvViewController.h"

@interface VVSwipeCell : SWTableViewCell

@property (weak, nonatomic) UILabel* countRoomLabel;
@property (weak, nonatomic) UILabel* titleLabel;
@property (weak, nonatomic) UILabel* roomLabel;

@property (strong, nonatomic) UIImage* disabledImage;
@property (strong, nonatomic) UIImage* enabledImage;

@property (strong, nonatomic) UIImageView* iconImageView;

@property (strong, nonatomic) UIButton* checkButton;

@property (strong, nonatomic) VVRealty* model;

@property (strong, nonatomic) VVMainAdvViewController* delegateController;

@end
