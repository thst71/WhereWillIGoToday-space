//
// Created by Thomas Strauß on 25.01.15.
// Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GT_Klasse : NSObject

@property(nonatomic, readonly) NSString *klasse;

- (instancetype)initWithKlasse:(NSString *)klasse;

+ (instancetype)klasseWithKlasse:(NSString *)klasse;


-(BOOL)matches:(NSString*)planEntry;

+ (BOOL)isAValidKlasse:(NSString *)klasse;
@end


extern NSString *cleanKlasseString(NSString *klasse);
