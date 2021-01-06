//
// Created by Thomas Strauß on 19.01.15.
// Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Marshaller.h"
#import "Unmarshaller.h"

@interface GT_PlanList : NSObject


+(id<Marshaller>)marshaller;
+(id<Unmarshaller>)unmarshaller;

@end