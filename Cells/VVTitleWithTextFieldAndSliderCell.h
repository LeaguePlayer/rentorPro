//
//  VVTitleWithTextFieldAndSliderCell.h
//  rentor
//
//  Created by vegera on 08.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVRealty.h"

@interface VVTitleWithTextFieldAndSliderCell : UITableViewCell

@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UITextField* costTextField;
@property (strong, nonatomic) UISlider* slider;
@property (strong, nonatomic) VVRealty* model;

@end
