//
//  VVFilterModel.h
//  rentor
//
//  Created by vegera on 01.08.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VVFilterModel : NSObject

@property (strong, nonatomic) NSString* user_id; // id пользователя

@property (strong, nonatomic) NSString* what_id; // тип недвижимости
@property (strong, nonatomic) NSString* what_label;
@property (strong, nonatomic) NSString* region_id; // район
@property (strong, nonatomic) NSString* region_label;
@property (strong, nonatomic) NSString* furniture_id; // мебель
@property (strong, nonatomic) NSString* furniture_label;
@property (strong, nonatomic) NSString* period_id; // срок
@property (strong, nonatomic) NSString* period_label;
@property (strong, nonatomic) NSString* option_id; // доп условия
@property (strong, nonatomic) NSString* option_label;

@property (strong, nonatomic) NSString* finished;


@property (strong, nonatomic) NSString* priceFrom; // цена от
@property (strong, nonatomic) NSString* priceTo; // цена до

@end
