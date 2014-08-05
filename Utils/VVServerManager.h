//
//  VVServerManager.h
//  rentor
//
//  Created by A-Mobile LLC on 24.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVUser.h"
#import "VVRealty.h"
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface VVServerManager : NSObject

- (BOOL)connected;

+ (VVServerManager *)sharedManager;

// Запрос авторизации
- (void)authUserWithPhoneNumber:(NSString *)phoneNumber
                       password:(NSString *)password
                      onSuccess:(void(^)(NSString* token))success
                      onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

// Запрос выхода из системы

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

// создаем объявление

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

// получить опции для страницы добавления: Принимаются следующие клиенты
- (void)getAdvertisingForId:(NSInteger)advertisingId
                  onSuccess:(void (^)(VVRealty* advertising))success
                  onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

@end
