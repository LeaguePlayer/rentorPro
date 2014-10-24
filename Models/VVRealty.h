//
//  VVRealty.h
//  rentor
//
//  Created by vegera on 25.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VVRealty : NSObject

@property (strong, nonatomic) NSString* id; // id
@property (strong, nonatomic) NSString* region; // район
@property (strong, nonatomic) NSMutableArray* regionArray; // район
@property (strong, nonatomic) NSString* modified; // Дата изменения
@property (strong, nonatomic) NSString* status; // Статус
@property (strong, nonatomic) NSString* price; // цена
@property (strong, nonatomic) NSString* user; // имя риелтора
@property (strong, nonatomic) NSString* phone; // Номер телефона
@property (strong, nonatomic) NSString* article; // артикул
@property (strong, nonatomic) NSString* type; // тип объявления
@property (strong, nonatomic) NSMutableArray* photos; // ссылки на фотки для объявления
@property (strong, nonatomic) NSString* furniture; // мебель
@property (strong, nonatomic) NSString* commune; // коммунальные платежи
@property (strong, nonatomic) NSString* state; // состояние
@property (strong, nonatomic) NSString* prepay; // предоплата
@property (strong, nonatomic) NSString* period; // срок сдачи
@property (strong, nonatomic) NSString* suite; // серия дома
@property (strong, nonatomic) NSString* what; // что (сколько комнат)
@property (strong, nonatomic) NSString* whos; // кому
@property (strong, nonatomic) NSString* condition; // условия
@property (strong, nonatomic) NSArray* mutualAdv; // количество похожих объявлений
@property (strong, nonatomic) NSString* comment_public; // коммент
@property (strong, nonatomic) NSString* comment_private; // коммент

@property (strong, nonatomic) NSMutableArray* whatArray; // что (сколько комнат)
@property (strong, nonatomic) NSMutableArray* whosArray; // кому

@property (strong, nonatomic) NSString* furnitureLabelText;
@property (strong, nonatomic) NSString* suiteLabelText;
@property (strong, nonatomic) NSString* regionLabelText;
@property (strong, nonatomic) NSString* periodLabelText;
@property (strong, nonatomic) NSString* whatLabelText;
@property (strong, nonatomic) NSString* whosLabelText;

@property (assign, nonatomic) BOOL malchild; // С мал.детьми
@property (assign, nonatomic) BOOL withanimal; // С животными
@property (assign, nonatomic) BOOL notrussia; // Не русские

@property (assign, nonatomic) BOOL selected;
@property (assign, nonatomic) BOOL notices;

- (id)initWithId:(id)obj;
- (id)initForEditWithId:(id)obj;

- (NSString *)getTypeString;
- (NSString *)getRieltor;
- (NSArray *)getOptions;
- (NSArray *)getWht;

@end
