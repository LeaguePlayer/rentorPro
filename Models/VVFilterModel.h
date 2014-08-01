//
//  VVFilterModel.h
//  rentor
//
//  Created by vegera on 01.08.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VVFilterModel : NSObject

@property (assign, nonatomic) NSInteger typeRealtyId; // тип недвижимости
@property (strong, nonatomic) NSString* typeRealtyLabel;
@property (assign, nonatomic) NSInteger districtId; // район
@property (strong, nonatomic) NSString* districtLabel;
@property (assign, nonatomic) NSInteger furnitureId; // мебель
@property (strong, nonatomic) NSString* furnitureLabel;
@property (assign, nonatomic) NSInteger periodId; // срок
@property (strong, nonatomic) NSString* periodLabel;
@property (strong, nonatomic) NSArray* additionalyOptionsIds; // доп условия
@property (strong, nonatomic) NSString* additionalyOptionsLabel;


@property (assign, nonatomic) NSInteger costFrom; // цена от
@property (assign, nonatomic) NSInteger costTo; // цена до

@end
