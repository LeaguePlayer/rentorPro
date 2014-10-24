//
//  VVUser.m
//  rentor
//
//  Created by vegera on 25.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVUser.h"

@implementation VVUser

static NSString* kUser_id = @"user_id";
static NSString* kRefer_id = @"refer_id";
static NSString* kLogin = @"login";
static NSString* kPhone = @"phone";
static NSString* kSms = @"sms";
static NSString* kNumbers = @"numbers";
static NSString* kSurname = @"surname";
static NSString* kFirstname = @"firstname";
static NSString* kLastname = @"lastname";
static NSString* kPhoto = @"photo";
static NSString* kEmail = @"email";
static NSString* kAbout = @"about";
static NSString* kDate_created = @"date_created";
static NSString* kDate_logged = @"date_logged";
static NSString* kDate_paid = @"date_paid";
static NSString* kDate_news = @"date_news";
static NSString* kBalance = @"balance";
static NSString* kAgency_id = @"agency_id";
static NSString* kTariff_id = @"tariff_id";
static NSString* kGroup_id = @"group_id";
static NSString* kVerified = @"verified";
static NSString* kApproved = @"approved";
static NSString* kArchived = @"archived";
static NSString* kBlacklist = @"blacklist";
static NSString* kGroup = @"group";
static NSString* kTariff_title = @"tariff_title";
static NSString* kAd_count = @"ad_count";
static NSString* kReferal_link = @"referal_link";

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
//        NSUserDefaults* userSettings = [NSUserDefaults standardUserDefaults];
        /*
        self.user_id = [dict objectForKey:kUser_id];
        self.refer_id = [dict objectForKey:kRefer_id];
        self.login;
        self.phone;
        self.sms;
        self.numbers;
        self.surname;
        self.firstname;
        self.lastname;
        self.photo;
        self.email;
        self.about;
        self.date_created;
        self.date_logged;
        self.date_paid;
        self.date_news;
        self.balance;
        self.agency_id;
        self.tariff_id;
        self.group_id;
        self.verified;
        self.approved;
        self.archived;
        self.blacklist;
        self.group;
        self.tariff_title;
        self.ad_count;
        self.referal_link;
        */
        
        /*
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
        @property (strong, nonatomic) NSDate* date_created;
        @property (strong, nonatomic) NSDate* date_logged;
        @property (strong, nonatomic) NSDate* date_paid;
        @property (strong, nonatomic) NSDate* date_news;
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
         
        
        [userSettings setObject:token forKey:kToken];
         */
        
//        [userSettings synchronize];
        
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
    }
    return self;
}

- (NSString *)getDateCreated
{
    return [self getDateFromString:self.date_created];
}

- (NSString *)getDateLogged
{
    return [self getDateFromString:self.date_logged];
}

- (NSString *)getDatePaid
{
    return [self getDateFromString:self.date_paid];
}

- (NSString *)getDateNews
{
    return [self getDateFromString:self.date_news];
}

- (NSString *)getDateFromString:(NSString *)stringDate
{
    return [stringDate substringToIndex:stringDate.length-3];
//    NSLog(@"getDateFromString: %@", [stringDate substringToIndex:stringDate.length-3]);
//    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"]; // 2014-03-05 00:00:00
//    NSDate* date = [dateFormatter dateFromString:stringDate];
//    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm"];
//    return [dateFormatter stringFromDate:date];
}

@end
