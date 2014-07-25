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

@property (assign, nonatomic) NSInteger countRoom; // количество комнат
@property (strong, nonatomic) NSString* district; // район
@property (strong, nonatomic) NSDate* changeDateTime; // Дата изменения
@property (strong, nonatomic) NSString* status; // Статус
@property (assign, nonatomic) NSInteger* cost; // цена
@property (strong, nonatomic) NSString* rieltorName; // имя риелтора
@property (strong, nonatomic) VVRieltor* rieltor; // объект риелтора

@end
