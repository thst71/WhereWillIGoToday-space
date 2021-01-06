//
// Created by Thomas Strauß on 23.02.15.
// Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SectionStatus : NSObject

@property (nonatomic) BOOL open;

- (instancetype)initWithOpen:(BOOL)open;

+ (instancetype)statusWithOpen:(BOOL)open;


@end