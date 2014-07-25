//
//  VVMainAdvTableViewCell.h
//  rentor
//
//  Created by vegera on 25.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VVMainAdvTableViewCell : UITableViewCell

#pragma mark - Properties

@property (weak, nonatomic) UILabel* countRoomLabel;
@property (weak, nonatomic) UILabel* titleLabel;
@property (weak, nonatomic) UILabel* roomLabel;

#pragma mark - Methods

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDictionary:(NSDictionary *)dictionary;

@end
