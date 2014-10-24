//
//  VVTwoTextViewWithTitleCell.m
//  rentor
//
//  Created by vegera on 08.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVTwoTextViewWithTitleCell.h"

@implementation VVTwoTextViewWithTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UITextView* privateCommentTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 34, 275, 87)];
        [privateCommentTextView setTag:1];
        
        //To make the border look very close to a UITextField
        [privateCommentTextView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
        [privateCommentTextView.layer setBorderWidth:0.5];
        
        //The rounded corner part, where you specify your view's corner radius:
        privateCommentTextView.layer.cornerRadius = 5;
        privateCommentTextView.clipsToBounds = YES;
        
        UITextView* publicCommentTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 151, 275, 87)];
        [publicCommentTextView setTag:2];
        
        //To make the border look very close to a UITextField
        [publicCommentTextView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
        [publicCommentTextView.layer setBorderWidth:0.5];
        
        //The rounded corner part, where you specify your view's corner radius:
        publicCommentTextView.layer.cornerRadius = 5;
        publicCommentTextView.clipsToBounds = YES;
        
        UILabel* privateTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 235, 21)];
        [privateTitleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:13.f]];
        [privateTitleLabel setTextColor:[UIColor colorWithRed:183.f/255.f green:183.f/255.f blue:183.f/255.f alpha:1.f]];
        
        UILabel* publicTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 129, 235, 21)];
        [publicTitleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:13.f]];
        [publicTitleLabel setTextColor:[UIColor colorWithRed:183.f/255.f green:183.f/255.f blue:183.f/255.f alpha:1.f]];
        
        [self.contentView addSubview:privateCommentTextView];
        [self.contentView addSubview:publicCommentTextView];
        [self.contentView addSubview:privateTitleLabel];
        [self.contentView addSubview:publicTitleLabel];
        
        self.privateTitleLabel = privateTitleLabel;
        self.publicTitleLabel = publicTitleLabel;
        self.privateCommentTextView = privateCommentTextView;
        self.publicCommentTextView = publicCommentTextView;
        
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
