//
// Created by Thomas Strauß on 02.03.15.
// Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GTSettings : NSObject

@property (strong, nonatomic) NSArray*favorites;

+(GTSettings*) settingsWithDictionary:(NSDictionary*)keys;

@end