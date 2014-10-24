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
#import "VVFilterModel.h"
#import "Reachability.h"
#import "VVDictionary.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface VVServerManager : NSObject

- (BOOL)connected;

+ (VVServerManager *)sharedManager;

// Запрос авторизации
- (void)authUserWithPhoneNumber:(NSString *)phoneNumber
                       password:(NSString *)password
                      onSuccess:(void(^)(NSString* token))success
                      onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

// запрос на получение словарей
- (void)getDictionaryForType:(NSString *)type
                   onSuccess:(void(^)(NSArray* dict))success
                   onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

// запрос на получение личных данных
// rentor.pro/api/users?do=get_user&token=7ab2d1a2c933d02419f258ce56c07a21&key=2f52c4944ea6b109548e1bac4a1e00b5&debug
- (void)getProfileDataOnSuccess:(void(^)(VVUser* user))success
                      onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

// запрос на получение личных данных
// rentor.pro/api/users?do=get_user&token=7ab2d1a2c933d02419f258ce56c07a21&secret_key=2f52c4944ea6b109548e1bac4a1e00b5&debug
//- (void)getPersonalData:(NSString *)token
//              onSuccess:(void(^)(* ))

// запрос на получение всех объявлений
// rentor.pro/api/ads?do=get_list&type=estate&offset=4&limit=5&token=7ab2d1a2c933d02419f258ce56c07a21&key=b30bd65e5ce98b03789a8f506210d878&debug
- (void)getAdvWithLimit:(NSInteger)limit
                 offset:(NSInteger)offset
                   type:(NSString *)type
                 filter:(VVFilterModel *)filter
              onSuccess:(void(^)(NSArray* adv, NSString* count))success
              onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

// запрос на получение всех объявлений
// rentor.pro/api/ads?do=get_list&type=estate&offset=4&limit=5&token=7ab2d1a2c933d02419f258ce56c07a21&key=b30bd65e5ce98b03789a8f506210d878&debug
- (void)getAdvForEditWithLimit:(NSInteger)limit
                        offset:(NSInteger)offset
                          type:(NSString *)type
                        filter:(VVFilterModel *)filter
                     onSuccess:(void(^)(NSArray* adv, NSString* count))success
                     onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

// запрос на получение всех объявлений
- (void)getNotificationAdvWithLimit:(NSInteger)limit
                             offset:(NSInteger)offset
                               type:(NSString *)type
                          onSuccess:(void(^)(NSArray* adv, NSString* count))success
                          onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

// запрос на добавление клиентов
- (void)postAdvWithType:(NSString *)type
                  price:(NSString *)price
                   what:(NSString *)what
                 region:(NSString *)region
              furniture:(NSString *)furniture
                 period:(NSString *)period
                 option:(NSString *)option
         comment_public:(NSString *)comment_public
        comment_private:(NSString *)comment_private
              onSuccess:(void(^)(NSString* insert_id))success
              onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;


// Запрос выхода из системы

// Запрос «Получить список объявлений»

// Запросы для получения значений фильтра.

// Запрос информации о конкретном объявлении.

// Запрос получения всех объявлений по ID

// Запрос редактирования объявления.

// Запрос получения оповещений.

// Запрос на продление объявления.
// rentor.pro/api/ads?do=edit_item&id=2068&item[expires]=2014-06-11%2006:18:28&token=7ab2d1a2c933d02419f258ce56c07a21&key=b30bd65e5ce98b03789a8f506210d878&debug
- (void)getProlongeAdvById:(NSString *)advId
                 onSuccess:(void(^)(NSString* result))success
                 onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

// Запрос на удаление объявления.
// rentor.pro/api/ads?do=del_item&id=2068&token=7ab2d1a2c933d02419f258ce56c07a21&key=b30bd65e5ce98b03789a8f506210d878&debug
- (void)getRemoveAdvById:(NSString *)advId
               onSuccess:(void(^)(NSString* result))success
               onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

// Запрос на снятие объявления.
// rentor.pro/api/ads?do=edit_item&id=2068&item[finished]=1&token=7ab2d1a2c933d02419f258ce56c07a21&key=b30bd65e5ce98b03789a8f506210d878&debug
- (void)getFinishedAdvById:(NSString *)advId
                 onSuccess:(void(^)(NSString* result))success
                 onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

// Запрос на получение моих объявлений.

// Запрос на добавление объявления

// Запрос на получение настроек

// создаем объявление

// получение списка уведомлений
// rentor.pro/api/ads?do=get_notices&type=estate&token=0b3237922358583bf3759bd11045123d&key=b30bd65e5ce98b03789a8f506210d878&debug
- (void)getNotificationOnType:(NSString *)type
                    onSuccess:(void(^)(id result))success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

// отправка данных на добавление недвижимости
- (void)postAdvFromModel:(VVRealty *)model
               onSuccess:(void(^)(id result))success
               onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

// получить опции для страницы добавления: Принимаются следующие клиенты
- (void)getAdvertisingForId:(NSInteger)advertisingId
                  onSuccess:(void (^)(VVRealty* advertising))success
                  onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

@end
