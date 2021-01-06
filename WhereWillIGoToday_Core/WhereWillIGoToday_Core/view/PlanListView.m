//
// Created by Thomas Strauß on 23.02.15.
// Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import "PlanListView.h"
#import "GT_Plan.h"
#import "GT_PlanEntry.h"
#import "GT_Klasse.h"
#import "AppService.h"
#import "GTSettings.h"


@implementation PlanListView {

}
- (NSArray *)loadFavorites {
    return nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.supports = [GT_Plan class];
    }

    return self;
}


- (void)find:(Callback)callback byKey:(NSString *)key {
    [super find:callback byKey:key];
}

- (void)find:(Callback)callback limit:(Limit *)limit {
    [super find:callback limit:limit];
}

- (void)find:(Callback)callback query:(Query *)query limit:(Limit *)limit {
    [super find:callback query:query limit:limit];
}


- (void)find:(Callback)callback plan:(NSString *)key klasse:(GT_Klasse *)zug {

    __block GT_Klasse *blockZug = zug;

    [self find:^(Result *result) {
                if (result && !result.isError) {
                    GT_Plan *thePlan = (GT_Plan *) result.data;
                    __block NSMutableArray *resultList = [NSMutableArray array];


                    [thePlan.entries enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        GT_PlanEntry *entry = obj;
                        if ([blockZug matches:entry.Klasse]) {
                            [resultList addObject:entry];
                        }
                    }];

                    forward(callback, [NSArray arrayWithArray:resultList], false);
                }
            }
         byKey:key
    ];
}


- (void)findAllPlans:(Callback)callback {
    [self find:^(Result *result) {
                if (result && !result.isError) {
                    if (![result.data isKindOfClass:[NSArray class]]) {
                        forward(callback, APP_ERROR_NO_DATA, true);
                        return;
                    }

                    NSArray *resultList = (NSArray *) result.data;
                    NSMutableArray *plans = [NSMutableArray arrayWithCapacity:resultList.count];


                    [resultList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        GT_Plan *entry = obj;
                        [plans addObject:entry.key];
                    }];

                    forward(callback, [NSArray arrayWithArray:plans], false);
                }
            }
         limit:[Limit limitWithStart:0 size:-1]
    ];
}

/**
*
* TODO implement favorites filter behavior:
* - load favorites from settings - no favorites, no filter
* - if there are favorites, iterate the plan, for each favorite, if the plan has an entry, that entry will be created like on plan view.
* - if there are no entries for the favorite, add a "no change" marker for the plan date
*/
- (NSArray *)loadFavorites:(NSArray *)planlist {

    GTSettings *settings = [self.appService.device settings];
    if (!settings) {return nil;}
    if (!settings.favorites) {return nil;}
    [settings.favorites enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *klasse = obj;
        // TODO filter out all entries from plan that have the class named, otherwise add entry with : "No changes"
    }];

    return nil;
}
@end