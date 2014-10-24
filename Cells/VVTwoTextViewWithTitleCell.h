//
//  VVTwoTextViewWithTitleCell.h
//  rentor
//
//  Created by vegera on 08.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VVTwoTextViewWithTitleCell : UITableViewCell

@property (strong, nonatomic) UILabel* privateTitleLabel;
@property (strong, nonatomic) UILabel* publicTitleLabel;

@property (strong, nonatomic) UITextView* privateCommentTextView;
@property (strong, nonatomic) UITextView* publicCommentTextView;

@end
