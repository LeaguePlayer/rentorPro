//
//  VVServerManager.h
//  rentor
//
//  Created by A-Mobile LLC on 24.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVUser.h"

@interface VVServerManager : NSObject

+ (VVServerManager *)sharedManager;

// Запрос авторизации
- (void) authorizeUser:(void(^)(VVUser* user))completion;

// Запрос «Получить список объявлений»

// Запросы для получения значений фильтра.

// Запрос информации о конкретном объявлении.

// Запрос получения всех объявлений по ID

// Запрос редактирования объявления.

// Запрос получения оповещений.

// Запрос на продление объявления.

// Запрос на удаление объявления.

// Запрос на снятие объявления.

// Запрос на получение моих объявлений.

// Запрос на добавление объявления

// Запрос на получение настроек
//- (void)getSettings

- (void)getCommentById:(NSString *)ids
               ownerID:(NSString *)ownerIDs
                 count:(NSInteger)count
                offset:(NSInteger)offset
             onSuccess:(void (^) (NSArray *wallComment))success
             onFailure:(void (^) (NSError *error)) failure;

// создаем объявление
- (void)postWallAddCommentText:(NSString*)text
                         image:(NSArray *)image
                   onGroupWall:(NSString*)groupID
                  onGroupTopic:(NSString*)topicID
                     onSuccess:(void(^)(id result))success
                     onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

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
                           onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

@end
