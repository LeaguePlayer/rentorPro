//
//  VVSettings.h
//  rentor
//
//  Created by vegera on 11.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VVSettings : NSObject

+ (VVSettings *)sharedManager;

- (void)saveToken:(NSString *)token;
- (NSString *)getToken;
- (void)removeToken;

- (void)saveUserId:(NSString *)userId;
- (NSString *)getUserId;
- (void)removeUserId;

@end
