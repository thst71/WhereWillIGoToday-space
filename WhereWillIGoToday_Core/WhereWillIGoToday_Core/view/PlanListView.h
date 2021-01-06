//
// Created by Thomas Strauß on 23.02.15.
// Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelView.h"

@class GT_Klasse;


@interface PlanListView : ModelView
- (void)find:(Callback)callback plan:(NSString *)key klasse:(GT_Klasse *)zug;

- (void)findAllPlans:(Callback)callback;

- (NSArray *)loadFavorites:(NSArray *)planlist;

- (NSArray *)loadFavorites;
@end