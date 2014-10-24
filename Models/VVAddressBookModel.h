//
//  VVAddressBookModel.h
//  Rentor
//
//  Created by vegera on 24.10.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VVAddressBookModel : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* phoneNumber;
@property (strong, nonatomic) UIImage* avatar;
@property (assign, nonatomic) BOOL selected;

@end
