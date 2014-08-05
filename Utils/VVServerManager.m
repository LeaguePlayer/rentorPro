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

static NSString* secretKey = @"dfgdfGt56HkdsDss874";

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
                                [self getSecretKey:secretKey withApiName:@"users"], @"secret_key",
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

#pragma mark - POST

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
                           onFailure:(void(^)(NSError* error, NSInteger statusCode))failure
{
    //
}

@end
