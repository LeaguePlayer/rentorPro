//
//  VVRealty.h
//  rentor
//
//  Created by vegera on 25.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVRieltor.h"

@interface VVRealty : NSObject

@property (strong, nonatomic) NSString* district; // район
@property (strong, nonatomic) NSDate* changeDateTime; // Дата изменения
@property (strong, nonatomic) NSString* status; // Статус
@property (assign, nonatomic) NSInteger* cost; // цена
@property (strong, nonatomic) NSString* rieltorName; // имя риелтора
// @property (strong, nonatomic) VVRieltor* rieltor; // объект риелтора
@property (strong, nonatomic) NSString* phoneNumber; // Номер телефона
@property (strong, nonatomic) NSString* article; // артикул
@property (strong, nonatomic) NSString* typeAdv; // тип объявления
@property (strong, nonatomic) NSArray* photoArray; // ссылки на фотки для объявления
@property (strong, nonatomic) NSString* furniture; // мебель
@property (strong, nonatomic) NSString* communePayment; // коммунальные платежи
@property (strong, nonatomic) NSString* state; // состояние
@property (strong, nonatomic) NSString* prepayment; // предоплата
@property (strong, nonatomic) NSString* period; // срок сдачи
@property (strong, nonatomic) NSString* serialNumber; // серия дома
@property (strong, nonatomic) NSString* countRoom; // что (сколько комнат)
@property (strong, nonatomic) NSString* options; // кому
@property (strong, nonatomic) NSString* condition; // условия
@property (assign, nonatomic) NSArray* mutualAdv; // количество похожих объявлений
@property (strong, nonatomic) NSString* publicComment; // коммент

@end
