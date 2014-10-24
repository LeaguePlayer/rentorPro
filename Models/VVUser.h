//
//  VVUser.h
//  rentor
//
//  Created by vegera on 25.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VVUser : NSObject

@property (strong, nonatomic) NSString* user_id;
@property (strong, nonatomic) NSString* refer_id;
@property (strong, nonatomic) NSString* login;
@property (strong, nonatomic) NSString* phone;
@property (strong, nonatomic) NSString* sms;
@property (strong, nonatomic) NSArray* numbers;
@property (strong, nonatomic) NSString* surname;
@property (strong, nonatomic) NSString* firstname;
@property (strong, nonatomic) NSString* lastname;
@property (strong, nonatomic) NSString* photo;
@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString* about;
@property (strong, nonatomic) NSString* date_created;
@property (strong, nonatomic) NSString* date_logged;
@property (strong, nonatomic) NSString* date_paid;
@property (strong, nonatomic) NSString* date_news;
@property (strong, nonatomic) NSString* balance;
@property (strong, nonatomic) NSString* agency_id;
@property (strong, nonatomic) NSString* tariff_id;
@property (strong, nonatomic) NSString* group_id;
@property (strong, nonatomic) NSString* verified;
@property (strong, nonatomic) NSString* approved;
@property (strong, nonatomic) NSString* archived;
@property (strong, nonatomic) NSArray* blacklist;
@property (strong, nonatomic) NSString* group;
@property (strong, nonatomic) NSString* tariff_title;
@property (strong, nonatomic) NSString* ad_count;
@property (strong, nonatomic) NSString* referal_link;

- (NSString *)getDateCreated;
- (NSString *)getDateLogged;
- (NSString *)getDatePaid;
- (NSString *)getDateNews;

/*
 [response] => Array
 (
 [id] => 1
 [refer_id] => 0
 [login] => admin
 [phone] => 9025138894
 [sms] => 9025138894
 [numbers] => Array
 (
 [0] => 9025138894
 [1] => 9025119970
 [2] => 9068222484
 [3] => 9248302808
 )
 
 [surname] => Зотов
 [firstname] => Алексей
 [lastname] => Александрович
 [md5password] => 76e355e62d20720f04df5ee7b2961e3a
 [photo] => /files/images/avatars/be203142f243b8d1ff705b3fb081bc51_s.jpg
 [email] => soleiz@mail.ru
 [about] =>
 [date_created] => 2014-03-05 00:00:00
 [date_logged] => 2014-08-18 09:50:17
 [date_paid] => 2018-04-05 00:00:00
 [date_news] => 2014-04-17 11:28:58
 [balance] => 200
 [agency_id] => 11
 [tariff_id] => 2
 [group_id] => 2
 [verified] => 0
 [approved] => 1
 [archived] => 0
 [group] => admin
 [tariff] => Array
 (
 [id] => 2
 [name] => partial
 [title] => Частичный
 [price] => 400
 [agency_only] => 0
 [deleted] => 0
 )
 
 [agency] => RENTOR
 [blacklist] => Array
 (
 )
 
 [ad_count] => 4
 [referal_link] => http://rentor.pro/add_user.htm?referal=user1_f2276fb877b7426296f40964b062b616
 )
 */

@end
