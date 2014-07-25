//
//  VVServerManager.m
//  rentor
//
//  Created by A-Mobile LLC on 24.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVServerManager.h"

@implementation VVServerManager

+ (VVServerManager *)sharedManager {
    
    static VVServerManager *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[VVServerManager alloc]init];
        
    });
    
    return manager;
}

#pragma mark - GET

#pragma mark - POST

// отправка данных на добавление недвижимости
- (void)postAdvertisingCommentPublic:(NSString *)commentPublic
                       commentHidden:(NSString *)commentHidden
                                show:(NSString *)show
                                what:(NSInteger)whatId
                             exoires:(NSInteger)expiresId
                               suite:(NSInteger)suiteId
                           furniture:(NSInteger)furnitureId
                             commune:(NSInteger)communId
                           condition:(NSInteger)conditionId
                               price:(NSInteger)price
                              period:(NSInteger)periodId
                              prepay:(NSInteger)prepayId
                              region:(NSInteger)regionId
                               trade:(BOOL)trade
                               owner:(BOOL)owner
                                keys:(BOOL)keys
                             options:(NSDictionary *)options // опции: Принимаются следующие клиенты
                                user:(VVUser *)user
                           onSuccess:(void(^)(id result))success
                           onFailure:(void(^)(NSError* error, NSInteger statusCode))failure
{
    //
}

@end
