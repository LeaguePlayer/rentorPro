//
//  VVSettings.m
//  rentor
//
//  Created by vegera on 11.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVSettings.h"

@interface VVSettings ()

@property (strong, nonatomic) NSString* token;
@property (strong, nonatomic) NSUserDefaults* userSettings;
@property (strong, nonatomic) NSString* userId;

@end

static NSString* kToken = @"token";
static NSString* kUserId = @"user_id";

@implementation VVSettings

static VVSettings* sharedManager = NULL;

+ (VVSettings *)sharedManager
{
    if (!sharedManager || sharedManager == NULL) {
		sharedManager = [VVSettings new];
        sharedManager.userSettings = [NSUserDefaults standardUserDefaults];
	}
	return sharedManager;
}

- (void)save
{
    [self.userSettings synchronize];
}

#pragma mark - Methods

- (void)saveToken:(NSString *)token
{
    _token = token;
    [self.userSettings setObject:token forKey:kToken];
    [self save];
}

- (NSString *)getToken
{
    if (!self.token.length > 0) {
        [self.userSettings objectForKey:kToken];
        return [self.userSettings objectForKey:kToken];
    }
    return self.token;
}

- (void)removeToken
{
    _token = nil;
    [self.userSettings removeObjectForKey:kToken];
    [self save];
}



- (void)saveUserId:(NSString *)userId
{
    _userId = userId;
    [self.userSettings setObject:userId forKey:kUserId];
    [self save];
}

- (NSString *)getUserId
{
    if (!self.userId.length > 0) {
        [self.userSettings objectForKey:kUserId];
        return [self.userSettings objectForKey:kUserId];
    }
    return self.userId;
}

- (void)removeUserId
{
    _userId = nil;
    [self.userSettings removeObjectForKey:kUserId];
    [self save];
}

@end
