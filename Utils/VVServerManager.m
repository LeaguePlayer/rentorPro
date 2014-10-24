//
//  VVServerManager.m
//  rentor
//
//  Created by A-Mobile LLC on 24.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVServerManager.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonDigest.h>

@interface VVServerManager()

@property (strong, nonatomic) AFHTTPRequestOperationManager* requestOperationManager;

@end

static NSString* secretKey = @"dP!7POznKVH\\w6cg9??W8";
static NSString* kToken = @"token";

@implementation VVServerManager

- (id)init
{
    self = [super init];
    if (self) {
        
        NSURL* url = [NSURL URLWithString:@"http://rentor.pro/api/"];
        
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    }
    return self;
}

+ (VVServerManager *)sharedManager {
    
    static VVServerManager *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[VVServerManager alloc]init];
        
    });
    
    return manager;
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

- (NSString *)getSecretKey:(NSString* )secretKey withApiName:(NSString *)apiName
{
    return [self md5HexDigest:[NSString stringWithFormat:@"%@%@", apiName, secretKey]];
}

- (NSString*)md5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

#pragma mark - GET

// Запрос авторизации
- (void)authUserWithPhoneNumber:(NSString *)phoneNumber
                       password:(NSString *)password
                      onSuccess:(void(^)(NSString* token))success
                      onFailure:(void(^)(NSError* error, NSInteger statusCode))failure
{
    if (![self connected]) {
        // not connected
        NSError* error;
        if (failure) {
            failure(error, 666);
        }
    } else {
        // connected, do some internet stuff
        NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"login", @"do",
                                [self getSecretKey:secretKey withApiName:@"users"], @"key",
                                [self md5HexDigest:phoneNumber], @"login",
                                [self md5HexDigest:password], @"password",
                                nil];
        NSLog(@"%@", params);
        
        [self.requestOperationManager GET:@"users"
                               parameters:params
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      NSLog(@"JSON: %@", responseObject);
                                      NSError* error;
                                      NSString* token;
                                      if ([[responseObject objectForKey:@"result"] integerValue] == 1) {
                                          token = [[responseObject objectForKey:@"response"] objectForKey:@"token"];
                                          if (success && token.length > 0) {
                                              success(token);
                                          } else {
                                              failure(error, 001);
                                          }
                                      } else {
                                          failure(error, 001);
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"Error: %@", error);
                                      
                                      if (failure) {
                                          failure(error, operation.response.statusCode);
                                      }
                                  }];
    }
}

// запрос на получение всех объявлений
// ads?do=get_list&type=estate&offset=4&limit=5&token=7ab2d1a2c933d02419f258ce56c07a21&key=b30bd65e5ce98b03789a8f506210d878&debug
- (void)getAdvWithLimit:(NSInteger)limit
                 offset:(NSInteger)offset
                   type:(NSString *)type
                 filter:(VVFilterModel *)filter
              onSuccess:(void(^)(NSArray* adv, NSString* count))success
              onFailure:(void(^)(NSError* error, NSInteger statusCode))failure
{
    if (![self connected]) {
        // not connected
        NSError* error;
        if (failure) {
            failure(error, 666);
        }
    } else {
        // connected, do some internet stuff
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                @"get_list", @"do",
                                [self getSecretKey:secretKey withApiName:@"ads"], @"key",
                                [NSString stringWithFormat:@"%@", type], @"type",
                                [NSString stringWithFormat:@"%d", offset], @"offset",
                                [NSString stringWithFormat:@"%d", limit], @"limit",
                                [[VVSettings sharedManager] getToken], @"token",
                                       nil];
        
        if (filter.user_id) {
            [params setValue:filter.user_id forKey:@"filter[user_id]"];
        }
        
        if (filter.what_id) {
            [params setValue:filter.what_id forKey:@"filter[what_id]"];
        }
        
        if (filter.furniture_id) {
            [params setValue:filter.furniture_id forKey:@"filter[furniture_id]"];
        }
        
        if (filter.period_id) {
            [params setValue:filter.period_id forKey:@"filter[period_id]"];
        }
        
        if (filter.region_id) {
            [params setValue:filter.region_id forKey:@"filter[region_id]"];
        }
        
        if (filter.priceFrom) {
            [params setValue:filter.priceFrom forKey:@"filter[price][from]"];
        }
        
        if (filter.priceTo) {
            [params setValue:filter.priceTo forKey:@"filter[price][to]"];
        }
        
        if (filter.finished) {
            [params setValue:filter.finished forKey:@"filter[finished]"];
        }
        
        NSLog(@"%@", params);
        
        [self.requestOperationManager GET:@"ads"
                               parameters:params
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                                      NSLog(@"JSON: %@", responseObject);
                                      
                                      NSError* error;
                                      if ([[responseObject objectForKey:@"result"] integerValue] == 1) {
                                          
                                          NSMutableArray* arrResponse = [NSMutableArray array];
                                          NSMutableArray* idsArray = [NSMutableArray array];
                                          NSArray* idsSortedArray;
                                          NSString* count;
                                          // NSLog(@"%@", [responseObject objectForKey:@"response"]);
                                          
                                          for (NSString* arr in [responseObject objectForKey:@"response"]) {
                                              if ([arr isEqualToString:@"count"]) {
                                                  count = [[responseObject objectForKey:@"response"] objectForKey:arr];
                                                  continue;
                                              }
                                              
                                              [idsArray addObject:arr];
                                          }
                                          
                                          idsSortedArray = [idsArray sortedArrayUsingFunction:intSort context:NULL];
                                          for (NSString* item in idsSortedArray) {
                                              VVRealty* realty = [[VVRealty alloc] initWithId:[[responseObject objectForKey:@"response"] objectForKey:item]];
                                              
                                              [arrResponse addObject:realty];
                                          }
//                                          NSLog(@"%@", arrResponse);
                                          
                                          if (success) {
                                              success(arrResponse, count);
                                          }
                                      } else {
                                          failure(error, 001);
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"Error: %@", error);
                                      
                                      if (failure) {
                                          failure(error, operation.response.statusCode);
                                      }
                                  }];
    }
}

// запрос на получение всех объявлений для редактирования
// ads?do=get_list&type=estate&offset=4&limit=5&token=7ab2d1a2c933d02419f258ce56c07a21&key=b30bd65e5ce98b03789a8f506210d878&debug
- (void)getAdvForEditWithLimit:(NSInteger)limit
                        offset:(NSInteger)offset
                          type:(NSString *)type
                        filter:(VVFilterModel *)filter
                     onSuccess:(void(^)(NSArray* adv, NSString* count))success
                     onFailure:(void(^)(NSError* error, NSInteger statusCode))failure
{
    if (![self connected]) {
        // not connected
        NSError* error;
        if (failure) {
            failure(error, 666);
        }
    } else {
        // connected, do some internet stuff
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"get_list", @"do",
                                       [self getSecretKey:secretKey withApiName:@"ads"], @"key",
                                       [NSString stringWithFormat:@"%@", type], @"type",
                                       [NSString stringWithFormat:@"%d", offset], @"offset",
                                       [NSString stringWithFormat:@"%d", limit], @"limit",
                                       [[VVSettings sharedManager] getToken], @"token",
                                       nil];
        
        if (filter.user_id) {
            [params setValue:filter.user_id forKey:@"filter[user_id]"];
        }
        
        if (filter.what_id) {
            [params setValue:filter.what_id forKey:@"filter[what_id]"];
        }
        
        if (filter.furniture_id) {
            [params setValue:filter.furniture_id forKey:@"filter[furniture_id]"];
        }
        
        if (filter.period_id) {
            [params setValue:filter.period_id forKey:@"filter[period_id]"];
        }
        
        if (filter.region_id) {
            [params setValue:filter.region_id forKey:@"filter[region_id]"];
        }
        
        if (filter.priceFrom) {
            [params setValue:filter.priceFrom forKey:@"filter[price][from]"];
        }
        
        if (filter.priceTo) {
            [params setValue:filter.priceTo forKey:@"filter[price][to]"];
        }
        
        if (filter.finished) {
            [params setValue:filter.finished forKey:@"filter[finished]"];
        }
        
        NSLog(@"%@", params);
        
        [self.requestOperationManager GET:@"ads"
                               parameters:params
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      //                                      NSLog(@"JSON: %@", responseObject);
                                      
                                      NSError* error;
                                      if ([[responseObject objectForKey:@"result"] integerValue] == 1) {
                                          
                                          NSMutableArray* arrResponse = [NSMutableArray array];
                                          NSMutableArray* idsArray = [NSMutableArray array];
                                          NSArray* idsSortedArray;
                                          NSString* count;
                                          
                                          for (NSString* arr in [responseObject objectForKey:@"response"]) {
                                              if ([arr isEqualToString:@"count"]) {
                                                  count = [[responseObject objectForKey:@"response"] objectForKey:arr];
                                                  continue;
                                              }
                                              
                                              [idsArray addObject:arr];
                                          }
                                          
                                          idsSortedArray = [idsArray sortedArrayUsingFunction:intSort context:NULL];
                                          for (NSString* item in idsSortedArray) {
                                              VVRealty* realty = [[VVRealty alloc] initForEditWithId:[[responseObject objectForKey:@"response"] objectForKey:item]];
                                              
                                              [arrResponse addObject:realty];
                                          }
                                          
                                          if (success) {
                                              success(arrResponse, count);
                                          }
                                      } else {
                                          failure(error, 001);
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"Error: %@", error);
                                      
                                      if (failure) {
                                          failure(error, operation.response.statusCode);
                                      }
                                  }];
    }
}

// запрос на получение всех объявлений
// ads?do=get_list&type=estate&offset=4&limit=5&token=7ab2d1a2c933d02419f258ce56c07a21&key=b30bd65e5ce98b03789a8f506210d878&debug
- (void)getNotificationAdvWithLimit:(NSInteger)limit
                             offset:(NSInteger)offset
                               type:(NSString *)type
                          onSuccess:(void(^)(NSArray* adv, NSString* count))success
                          onFailure:(void(^)(NSError* error, NSInteger statusCode))failure
{
    if (![self connected]) {
        // not connected
        NSError* error;
        if (failure) {
            failure(error, 666);
        }
    } else {
        // connected, do some internet stuff
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"get_notices", @"do",
                                       [self getSecretKey:secretKey withApiName:@"ads"], @"key",
                                       [NSString stringWithFormat:@"%@", type], @"type",
                                       [NSString stringWithFormat:@"%d", offset], @"offset",
                                       [NSString stringWithFormat:@"%d", limit], @"limit",
                                       [[VVSettings sharedManager] getToken], @"token",
                                       nil];
        
        NSLog(@"%@", params);
        
        [self.requestOperationManager GET:@"ads"
                               parameters:params
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      // NSLog(@"JSON: %@", responseObject);
                                      
                                      NSError* error;
                                      if ([[responseObject objectForKey:@"result"] integerValue] == 1) {
                                          
                                          NSMutableArray* arrResponse = [[NSMutableArray alloc] init];
                                          NSString* count;
                                          // NSLog(@"%@", [responseObject objectForKey:@"response"]);
                                          
                                          for (NSString* itemId in [responseObject objectForKey:@"response"]) {
                                              // item
                                              if ([itemId isEqualToString:@"count"]) {
                                                  continue;
                                              }
                                              VVRealty* realty = [[VVRealty alloc] initWithId:[[[responseObject objectForKey:@"response"] objectForKey:itemId] objectForKey:@"item"]];
                                              
                                              [arrResponse addObject:realty];
                                              
                                              for (id itemObj in [[[responseObject objectForKey:@"response"] objectForKey:itemId] objectForKey:@"notices"]) {
                                                  VVRealty* realty = [[VVRealty alloc] initWithId:itemObj];
                                                  realty.notices = YES;
                                                  
                                                  [arrResponse addObject:realty];
                                              }
                                          }
                                          // NSLog(@"%@", arrResponse);
                                          
                                          if (success) {
                                              success(arrResponse, count);
                                          }
                                      } else {
                                          failure(error, 001);
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"Error: %@", error);
                                      
                                      if (failure) {
                                          failure(error, operation.response.statusCode);
                                      }
                                  }];
    }
}

// Запрос на удаление объявления.
// rentor.pro/api/ads?do=del_item&id=2068&token=7ab2d1a2c933d02419f258ce56c07a21&key=b30bd65e5ce98b03789a8f506210d878&debug
- (void)getRemoveAdvById:(NSString *)advId
               onSuccess:(void(^)(NSString* result))success
               onFailure:(void(^)(NSError* error, NSInteger statusCode))failure
{
    if (![self connected]) {
        // not connected
        NSError* error;
        if (failure) {
            failure(error, 666);
        }
    } else {
        // connected, do some internet stuff
        NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"del_item", @"do",
                                [self getSecretKey:secretKey withApiName:@"ads"], @"key",
                                [[VVSettings sharedManager] getToken], @"token",
                                advId, @"id",
                                nil];
        NSLog(@"%@", params);
        
        [self.requestOperationManager GET:@"ads"
                               parameters:params
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      NSLog(@"JSON: %@", responseObject);
                                      
                                      NSError* error;
                                      if ([[responseObject objectForKey:@"result"] integerValue] == 1) {
                                          
                                          
                                          if (success) {
                                              success(@"YES");
                                          }
                                      } else {
                                          failure(error, 001);
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"Error: %@", error);
                                      
                                      if (failure) {
                                          failure(error, operation.response.statusCode);
                                      }
                                  }];
    }
}

// Запрос на снятие объявления.
// rentor.pro/api/ads?do=edit_item&id=2068&item[finished]=1&token=7ab2d1a2c933d02419f258ce56c07a21&key=b30bd65e5ce98b03789a8f506210d878&debug
- (void)getFinishedAdvById:(NSString *)advId
                 onSuccess:(void(^)(NSString* result))success
                 onFailure:(void(^)(NSError* error, NSInteger statusCode))failure
{
    if (![self connected]) {
        // not connected
        NSError* error;
        if (failure) {
            failure(error, 666);
        }
    } else {
        // connected, do some internet stuff
        NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"edit_item", @"do",
                                [self getSecretKey:secretKey withApiName:@"ads"], @"key",
                                [[VVSettings sharedManager] getToken], @"token",
                                @"1", @"item[finished]",
                                advId, @"id",
                                nil];
        NSLog(@"%@", params);
        
        [self.requestOperationManager GET:@"ads"
                               parameters:params
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      NSLog(@"JSON: %@", responseObject);
                                      
                                      NSError* error;
                                      if ([[responseObject objectForKey:@"result"] integerValue] == 1) {
                                          
                                          if (success) {
                                              success(@"YES");
                                          }
                                      } else {
                                          failure(error, 001);
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"Error: %@", error);
                                      
                                      if (failure) {
                                          failure(error, operation.response.statusCode);
                                      }
                                  }];
    }
}

// Запрос на продление объявления.
// rentor.pro/api/ads?do=edit_item&id=2068&item[expires]=2014-06-11%2006:18:28&token=7ab2d1a2c933d02419f258ce56c07a21&key=b30bd65e5ce98b03789a8f506210d878&debug
- (void)getProlongeAdvById:(NSString *)advId
                 onSuccess:(void(^)(NSString* result))success
                 onFailure:(void(^)(NSError* error, NSInteger statusCode))failure
{
    if (![self connected]) {
        // not connected
        NSError* error;
        if (failure) {
            failure(error, 666);
        }
    } else {
        // connected, do some internet stuff
        NSDate* mydate = [NSDate date];
        NSTimeInterval secondsInEightHours = 72 * 60 * 60;
        NSDate* dateEightHoursAhead = [mydate dateByAddingTimeInterval:secondsInEightHours];
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        
        NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"edit_item", @"do",
                                [self getSecretKey:secretKey withApiName:@"ads"], @"key",
                                [[VVSettings sharedManager] getToken], @"token",
                                [dateFormatter stringFromDate:dateEightHoursAhead], @"item[expires]",
                                advId, @"id",
                                @"0", @"item[finished]",
                                nil];
        NSLog(@"%@", params);
        
        [self.requestOperationManager GET:@"ads"
                               parameters:params
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      NSLog(@"JSON: %@", responseObject);
                                      
                                      NSError* error;
                                      if ([[responseObject objectForKey:@"result"] integerValue] == 1) {
                                          
                                          
                                          if (success) {
                                              success(@"YES");
                                          }
                                      } else {
                                          failure(error, 001);
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"Error: %@", error);
                                      
                                      if (failure) {
                                          failure(error, operation.response.statusCode);
                                      }
                                  }];
    }
}

// запрос на получение личных данных
// rentor.pro/api/users?do=get_user&token=7ab2d1a2c933d02419f258ce56c07a21&key=2f52c4944ea6b109548e1bac4a1e00b5&debug
- (void)getProfileDataOnSuccess:(void(^)(VVUser* user))success
                      onFailure:(void(^)(NSError* error, NSInteger statusCode))failure
{
    if (![self connected]) {
        // not connected
        NSError* error;
        if (failure) {
            failure(error, 666);
        }
    } else {
        // connected, do some internet stuff
        NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"get_user", @"do",
                                [self getSecretKey:secretKey withApiName:@"users"], @"key",
                                [[VVSettings sharedManager] getToken], @"token",
                                nil];
        NSLog(@"%@", params);
        
        [self.requestOperationManager GET:@"users"
                               parameters:params
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      NSLog(@"JSON: %@", responseObject);
                                      
                                      NSError* error;
                                      if ([[responseObject objectForKey:@"result"] integerValue] == 1) {
                                          VVUser* currentUser = [[VVUser alloc] init];
                                          currentUser.user_id = [[responseObject objectForKey:@"response"] objectForKey:@"id"];
                                          currentUser.refer_id = [[responseObject objectForKey:@"response"] objectForKey:@"refer_id"];
                                          currentUser.login = [[responseObject objectForKey:@"response"] objectForKey:@"login"];
                                          currentUser.phone = [[responseObject objectForKey:@"response"] objectForKey:@"phone"];
                                          currentUser.sms = [[responseObject objectForKey:@"response"] objectForKey:@"sms"];
                                          currentUser.surname = [[responseObject objectForKey:@"response"] objectForKey:@"surname"];
                                          currentUser.firstname = [[responseObject objectForKey:@"response"] objectForKey:@"firstname"];
                                          currentUser.lastname = [[responseObject objectForKey:@"response"] objectForKey:@"lastname"];
                                          currentUser.photo = [[responseObject objectForKey:@"response"] objectForKey:@"photo"];
                                          currentUser.email = [[responseObject objectForKey:@"response"] objectForKey:@"email"];
                                          currentUser.about = [[responseObject objectForKey:@"response"] objectForKey:@"about"];
                                          currentUser.date_created = [[responseObject objectForKey:@"response"] objectForKey:@"date_created"];
                                          currentUser.date_logged = [[responseObject objectForKey:@"response"] objectForKey:@"date_logged"];
                                          currentUser.date_paid = [[responseObject objectForKey:@"response"] objectForKey:@"date_paid"];
                                          currentUser.date_news = [[responseObject objectForKey:@"response"] objectForKey:@"date_news"];
                                          currentUser.balance = [[responseObject objectForKey:@"response"] objectForKey:@"balance"];
                                          currentUser.agency_id = [[responseObject objectForKey:@"response"] objectForKey:@"agency_id"];
                                          currentUser.tariff_id = [[responseObject objectForKey:@"response"] objectForKey:@"tariff_id"];
                                          currentUser.group_id = [[responseObject objectForKey:@"response"] objectForKey:@"group_id"];
                                          currentUser.verified = [[responseObject objectForKey:@"response"] objectForKey:@"verified"];
                                          currentUser.approved = [[responseObject objectForKey:@"response"] objectForKey:@"approved"];
                                          currentUser.archived = [[responseObject objectForKey:@"response"] objectForKey:@"archived"];
                                          currentUser.tariff_title = [[[responseObject objectForKey:@"response"] objectForKey:@"tariff"] objectForKey:@"title"];
                                          currentUser.referal_link = [[responseObject objectForKey:@"response"] objectForKey:@"referal_link"];
                                          currentUser.ad_count = [[responseObject objectForKey:@"response"] objectForKey:@"ad_count"];
                                          
                                          NSLog(@"currentUser: %@", currentUser);
                                          
                                          if (success) {
                                              success(currentUser);
                                          }
                                      } else {
                                          failure(error, 001);
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"Error: %@", error);
                                      
                                      if (failure) {
                                          failure(error, operation.response.statusCode);
                                      }
                                  }];
    }
}

// запрос на получение словарей
// rentor.pro/api/ads?do=get_filter&token=7ab2d1a2c933d02419f258ce56c07a21&key=b30bd65e5ce98b03789a8f506210d878&type=whats&debug
- (void)getDictionaryForType:(NSString *)type
                   onSuccess:(void(^)(NSArray* dict))success
                   onFailure:(void(^)(NSError* error, NSInteger statusCode))failure
{
    if (![self connected]) {
        // not connected
        NSError* error;
        if (failure) {
            failure(error, 666);
        }
    } else {
        /*
         whos - виды клиентов
         whats - виды недвижимости
         regions - области
         furnitures - виды мебели
         periods - срок
         options - дополнительные условия
         */
        // connected, do some internet stuff
        NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"get_filter", @"do",
                                [self getSecretKey:secretKey withApiName:@"ads"], @"key",
                                type, @"type",
                                [[VVSettings sharedManager] getToken], @"token",
                                nil];
        NSLog(@"%@", params);
        
        [self.requestOperationManager GET:@"ads"
                               parameters:params
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      NSLog(@"JSON: %@", responseObject);
                                      
                                      NSError* error;
                                      if ([[responseObject objectForKey:@"result"] integerValue] == 1) {
                                          
                                          NSMutableArray* arrResponse = [[NSMutableArray alloc] init];
                                          NSLog(@"%@", [responseObject objectForKey:@"response"]);
                                          
                                          for (NSString* arr in [responseObject objectForKey:@"response"]) {
                                              VVDictionary* dict = [[VVDictionary alloc] init];
                                              [dict setId:arr];
                                              [dict setTitle:[[responseObject objectForKey:@"response"] objectForKey:arr]];
                                              [arrResponse addObject:dict];
                                          }
                                          NSLog(@"%@", arrResponse);
                                          
                                          if (success) {
                                              success(arrResponse);
                                          }
                                      } else {
                                          failure(error, 001);
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"Error: %@", error);
                                      
                                      if (failure) {
                                          failure(error, operation.response.statusCode);
                                      }
                                  }];
    }
}

// запрос персональных данных
// rentor.pro/api/users?do=get_user&token=7ab2d1a2c933d02419f258ce56c07a21&secret_key=2f52c4944ea6b109548e1bac4a1e00b5&debug

#pragma mark - POST

// отправка данных на добавление недвижимости
// rentor.pro/api/ads?do=add_item&item%5Bprice%5D=100500&token=7ab2d1a2c933d02419f258ce56c07a21&key=b30bd65e5ce98b03789a8f506210d878&debug
- (void)postAdvFromModel:(VVRealty *)model
               onSuccess:(void(^)(id result))success
               onFailure:(void(^)(NSError* error, NSInteger statusCode))failure
{
    if (![self connected]) {
        // not connected
        NSError* error;
        if (failure) {
            failure(error, 666);
        }
    } else {
        // connected, do some internet stuff
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"add_item", @"do",
                                       [self getSecretKey:secretKey withApiName:@"ads"], @"key",
                                       [[VVSettings sharedManager] getToken], @"token",
                                       model.type, @"item[type]",
                                       nil];
        
        if (model.price) {
            [params setObject:model.price forKey:@"item[price]"];
        }
        
        if (model.comment_public) {
            [params setObject:model.comment_public forKey:@"item[comment_public]"];
        }
        
        if (model.comment_private) {
            [params setObject:model.comment_private forKey:@"item[comment_hidden]"];
        }
        
        if (model.region) {
            [params setObject:model.region forKey:@"item[region_id]"];
        }
        
        if (model.period) {
            [params setObject:model.period forKey:@"item[period_id]"];
        }
        
        if (model.suite) {
            [params setObject:model.suite forKey:@"item[suite_id]"];
        }
        
        if (model.furniture) {
            [params setObject:model.furniture forKey:@"item[furniture_id]"];
        }
        
        if ([model.type isEqualToString:@"client"]) {
            if ([model.getWht count] > 0) {
                [params setObject:model.getWht forKey:@"item[whats]"];
            }
            
            if (model.whos) {
                [params setObject:model.whos forKey:@"item[who_id]"];
            }
        } else {
            if ([model.getWht count] > 0) {
                [params setObject:model.getWht forKey:@"item[whos]"];
            }
            
            if (model.what) {
                [params setObject:model.what forKey:@"item[what_id]"];
            }
        }
        
        if ([model.getOptions count] > 0) {
            [params setObject:model.getOptions forKey:@"item[options]"];
        }
        
        NSLog(@"%@", params);
        
        [self.requestOperationManager POST:@"ads"
                                parameters:params
                 constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                     int i = 0;
                     for (UIImage* img in model.photos) {
                         NSData* imageData = UIImageJPEGRepresentation(img, 0.5);
                         [formData appendPartWithFileData:imageData
                                                     name:[NSString stringWithFormat:@"photos\[%d\]", i ]
                                                 fileName:[NSString stringWithFormat:@"file%d.jpg", i ]
                                                 mimeType:@"image/jpeg"];
                         i++;
                     }
                 }
                                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       NSLog(@"Success: %@", responseObject);
                                       
                                       success([responseObject objectForKey:@"insert_id"]);
                                   }
                                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                       NSLog(@"Error: %@", error);
                                       
                                       if (failure) {
                                           failure(error, operation.response.statusCode);
                                       }
                                   }];
    }
}

#pragma mark - SortMethods

static NSInteger intSort(id num1, id num2, void *context)
{
    int v1 = [num1 intValue];
    int v2 = [num2 intValue];
    if (v1 > v2)
        return NSOrderedAscending;
    else if (v1 < v2)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

@end
