//
//  VVRealty.m
//  rentor
//
//  Created by vegera on 25.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVRealty.h"
#import "VVDictionary.h"

@implementation VVRealty

- (instancetype)initWithId:(id)obj
{
    self = [super init];
    if (self) {
        self.photos = [NSMutableArray array];
        self.whatArray = [NSMutableArray array];
        self.whosArray = [NSMutableArray array];
        self.price = @"2000";
        self.whos = @"";
        self.suiteLabelText = @"";
        self.furnitureLabelText = @"";
        self.whatLabelText = @"";
        self.periodLabelText = @"";
        self.regionLabelText = @"";
      
        NSMutableArray *regionArray = [NSMutableArray array];
        for (NSString *region in [obj objectForKey:@"regions"]) {
            [regionArray addObject:[[obj objectForKey:@"regions"] objectForKey:region]];
        }
        self.region = [regionArray componentsJoinedByString:@", "];
      
        if (![[obj objectForKey:@"modified"] isEqual:[NSNull null]]) {
            self.modified = [obj objectForKey:@"modified"];
        }

        if (![[obj objectForKey:@"furniture"] isEqual:[NSNull null]]) {
            self.furniture = [obj objectForKey:@"furniture"];
        }

        if (![[obj objectForKey:@"price"] isEqual:[NSNull null]]) {
            self.price = [NSString stringWithFormat:@"%@ р.", [obj objectForKey:@"price"]];
        }
      
        self.article = [NSString stringWithFormat:@"E%@", [obj objectForKey:@"id"]];
        self.id = [obj objectForKey:@"id"];
        self.user = [obj objectForKey:@"user"];
        self.phone = [obj objectForKey:@"phone"];

        if (![[obj objectForKey:@"whos"] isEqual:[NSNull null]]) {
            NSMutableArray *whosArray = [NSMutableArray array];
            for (NSString* whos in [obj objectForKey:@"whos"]) {
                [whosArray addObject:[[obj objectForKey:@"whos"] objectForKey:whos]];
            }
            self.whos = [whosArray componentsJoinedByString:@", "];
        }

        if (![[obj objectForKey:@"options"] isEqual:[NSNull null]]) {
            NSMutableArray *optionsArray = [NSMutableArray array];
            for (NSString* options in [obj objectForKey:@"options"]) {
                [optionsArray addObject:[[obj objectForKey:@"options"] objectForKey:options]];
            }
            self.condition = [optionsArray componentsJoinedByString:@", "];
        }

        self.type = [obj objectForKey:@"type"];
        //
        NSMutableArray* realtyPhotos = [[NSMutableArray alloc] init];
        for (NSString* photos in [obj objectForKey:@"photos"]) {
            [realtyPhotos addObject:photos];
        }
        self.photos = realtyPhotos;

        self.comment_public = [obj objectForKey:@"comment_public"];

        if (![[obj objectForKey:@"commune"] isEqual:[NSNull null]]) {
            self.commune = [obj objectForKey:@"commune"];
        }

        if ([[obj objectForKey:@"prepay"] integerValue] == 0) {
            self.prepay = [NSString stringWithFormat:@"нет"];
        } else {
            self.prepay = [NSString stringWithFormat:@"%@ мес", [obj objectForKey:@"prepay"]];
        }

        self.period = [obj objectForKey:@"period"];

        if (![[obj objectForKey:@"what"] isEqual:[NSNull null]]) {
        self.what = [obj objectForKey:@"what"];
        } else { // для клиентов эти данные в массиве приходят
            for (NSString* what in [obj objectForKey:@"whats"]) {
                self.what = [[obj objectForKey:@"whats"] objectForKey:what];
                break;
            }
        }
        
        if (![[obj objectForKey:@"suite"] isEqual:[NSNull null]]) {
            self.suite = [obj objectForKey:@"suite"];
        }
    }
    return self;
}

- (instancetype)initForEditWithId:(id)obj
{
    self = [super init];
    if (self) {
        self.photos = [NSMutableArray array];
        self.whatArray = [NSMutableArray array];
        self.whosArray = [NSMutableArray array];
        self.price = @"2000";
        self.whos = @"";
        self.suiteLabelText = @"";
        self.furnitureLabelText = @"";
        self.whatLabelText = @"";
        self.periodLabelText = @"";
        self.regionLabelText = @"";
        self.comment_public = @"";
        self.comment_private = @"";
        
        NSMutableArray *regionArray = [NSMutableArray array];
        NSMutableArray *regionIdArray = [NSMutableArray array];
        for (NSString *region in [obj objectForKey:@"regions"]) {
            [regionArray addObject:[[obj objectForKey:@"regions"] objectForKey:region]];
            [regionIdArray addObject:region];
        }
        self.regionLabelText = [regionArray componentsJoinedByString:@", "];
        self.regionArray = regionIdArray;
        
        if (![[obj objectForKey:@"modified"] isEqual:[NSNull null]]) {
            self.modified = [obj objectForKey:@"modified"];
        }
        
        if (![[obj objectForKey:@"furniture"] isEqual:[NSNull null]]) {
            self.furnitureLabelText = [obj objectForKey:@"furniture"];
        }
        
        if (![[obj objectForKey:@"furniture_id"] isEqual:[NSNull null]]) {
            self.furniture = [obj objectForKey:@"furniture_id"];
        }
        
        if (![[obj objectForKey:@"price"] isEqual:[NSNull null]]) {
            self.price = [obj objectForKey:@"price"];
        }
        
        self.article = [NSString stringWithFormat:@"E%@", [obj objectForKey:@"id"]];
        self.id = [obj objectForKey:@"id"];
        self.user = [obj objectForKey:@"user"];
        self.phone = [obj objectForKey:@"phone"];
        
        if (![[obj objectForKey:@"whos"] isEqual:[NSNull null]]) {
            NSMutableArray *whosArray = [NSMutableArray array];
            NSMutableArray *whosIdArray = [NSMutableArray array];
            for (NSString* whos in [obj objectForKey:@"whos"]) {
                [whosArray addObject:[[obj objectForKey:@"whos"] objectForKey:whos]];
                [whosIdArray addObject:whos];
            }
            self.whosLabelText = [whosArray componentsJoinedByString:@", "];
            self.whosArray = whosIdArray;
        }
        
        if (![[obj objectForKey:@"options"] isEqual:[NSNull null]]) {
            NSMutableArray *optionsArray = [NSMutableArray array];
            for (NSString* options in [obj objectForKey:@"options"]) {
                [optionsArray addObject:[[obj objectForKey:@"options"] objectForKey:options]];
                
                if ([options isEqualToString:@"2"]) {
                    self.malchild = YES;
                }
                
                if ([options isEqualToString:@"3"]) {
                    self.withanimal = YES;
                }
                
                if ([options isEqualToString:@"4"]) {
                    self.notrussia = YES;
                }
            }
            self.condition = [optionsArray componentsJoinedByString:@", "];
        }
        
        self.type = [obj objectForKey:@"type"];
        //
        NSMutableArray* realtyPhotos = [[NSMutableArray alloc] init];
        for (NSString* photos in [obj objectForKey:@"photos"]) {
            [realtyPhotos addObject:photos];
        }
        self.photos = realtyPhotos;
        
        self.comment_public = [obj objectForKey:@"comment_public"];
        self.comment_private = [obj objectForKey:@"comment_hidden"];
        
        if (![[obj objectForKey:@"commune"] isEqual:[NSNull null]]) {
            self.commune = [obj objectForKey:@"commune"];
        }
        
        if ([[obj objectForKey:@"prepay"] integerValue] == 0) {
            self.prepay = [NSString stringWithFormat:@"нет"];
        } else {
            self.prepay = [NSString stringWithFormat:@"%@ мес", [obj objectForKey:@"prepay"]];
        }
        
        self.period = [obj objectForKey:@"period"];
        
        if (![[obj objectForKey:@"what_id"] isEqual:[NSNull null]]) {
            self.what = [obj objectForKey:@"what_id"];
        }
        
        if (![[obj objectForKey:@"what"] isEqual:[NSNull null]]) {
            self.whatLabelText = [obj objectForKey:@"what"];
        } else { // для клиентов эти данные в массиве приходят
            for (NSString* what in [obj objectForKey:@"whats"]) {
                self.what = [[obj objectForKey:@"whats"] objectForKey:what];
                break;
            }
        }
        
        if (![[obj objectForKey:@"suite"] isEqual:[NSNull null]]) {
            self.suiteLabelText = [obj objectForKey:@"suite"];
        }
        
        if (![[obj objectForKey:@"suite_id"] isEqual:[NSNull null]]) {
            self.suite = [obj objectForKey:@"suite_id"];
        }
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.photos = [NSMutableArray array];
        self.whatArray = [NSMutableArray array];
        self.whosArray = [NSMutableArray array];
        self.price = @"2000";
        self.whos = @"";
    }
    return self;
}

- (NSString *)getTypeString
{
    if ([self.type isEqualToString:@"estate"]) {
        return @"Недвижимость";
    } else {
        return @"Клиент";
    }
}

- (NSString *)getRieltor
{
    return [NSString stringWithFormat:@"%@ +7%@", self.user, self.phone];
}

- (NSArray *)getOptions
{
    NSMutableArray* options = [NSMutableArray array];
    
    if (self.malchild) {
        [options addObject:@"2"];
    }
    
    if (self.withanimal) {
        [options addObject:@"3"];
    }
    
    if (self.notrussia) {
        [options addObject:@"4"];
    }
    
    return options;
}

- (NSArray *)getWht
{
    NSMutableArray* whos = [NSMutableArray array];
    NSMutableArray* whats = [NSMutableArray array];
    if ([self.type isEqualToString:@"client"]) {
        for (VVDictionary* dict in self.whatArray) {
            if (dict.selected) {
                [whats addObject:dict.id];
            }
        }
        return whats;
    } else {
        for (VVDictionary* dict in self.whosArray) {
            if (dict.selected) {
                [whos addObject:dict.id];
            }
        }
        return whos;
    }
    return @[];
}

@end
