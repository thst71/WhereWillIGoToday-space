//
// Created by Thomas Strauß on 02.03.15.
// Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import "GTSettings.h"
#import "AppEnvironment.h"


@implementation GTSettings {

}

- (instancetype)init {
    self = [super init];
    if (self) {
    }

    return self;
}

+ (GTSettings *)settingsWithDictionary:(NSDictionary*)keys {

    GTSettings *s = [[GTSettings alloc]init];

    s.favorites = (NSArray*)(keys[APP_KEY_SETTINGS_FAVORITES]) ? keys[APP_KEY_SETTINGS_FAVORITES] : nil;

    return s;
}


@end