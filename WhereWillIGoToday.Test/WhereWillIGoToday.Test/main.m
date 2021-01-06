//
//  main.m
//  WhereWillIGoToday.Test
//
//  Created by Thomas Strauß on 14.01.15.
//  Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppBridge.h"
#import "GT_Plan.h"
#import "GTSettings.h"
#import "PlanListView.h"

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        NSLog(@"Hello, World!");

        AppBridge *bridge = [AppBridge instance];

        AppService *service = [bridge appService];

        [bridge startup:LC_ALL];

        [service find:^(Result *result) {
                    NSLog(@"offline %@", result);
                }
                query:nil
                limit:nil
             forClass:[GT_Plan class]];

        [[NSNotificationCenter defaultCenter] postNotificationName:APP_NOTIFICATION_ONLINE_UPDATE object:nil];

        [service find:^(Result *result) {
                    NSLog(@"online %@", result);
                }
                query:nil
                limit:nil
             forClass:[GT_Plan class]];

//        NSString* today = todayKey();
//        NSString* tomorrow = tomorrowKey();

        [service find:^(Result *result) {
                    NSLog(@"%@", result);
                }
                 plan:@"23.02.2015"
               klasse:[GT_Klasse klasseWithKlasse:@"5e"]];

        {
            GT_Klasse *tk1 = [GT_Klasse klasseWithKlasse:@"q1"];
            GT_Klasse *tk2 = [GT_Klasse klasseWithKlasse:@"0e5"];
            GT_Klasse *tk3 = [GT_Klasse klasseWithKlasse:@"9f"];
            GT_Klasse *tk4 = [GT_Klasse klasseWithKlasse:@"06E"];

            NSLog(@"tk1: %@\ntk2: %@\ntk3: %@\ntk4: %@", tk1.klasse, tk2.klasse, tk3.klasse, tk4.klasse);
        }

        {
            GT_Klasse *tk1 = [GT_Klasse klasseWithKlasse:@":Mensa"];
            GT_Klasse *tk2 = [GT_Klasse klasseWithKlasse:@":MIPA"];
            GT_Klasse *tk3 = [GT_Klasse klasseWithKlasse:@"e1"];
            GT_Klasse *tk4 = [GT_Klasse klasseWithKlasse:@"1a"];

            NSLog(@"tk1: %@\ntk2: %@\ntk3: %@\ntk4: %@", tk1.klasse, tk2.klasse, tk3.klasse, tk4.klasse);
        }

        AppDevice *device = [[AppDevice alloc] init];
        NSLog(@"%@", [[device settings] favorites]);

        [device addFavorite:@"05E"];

        PlanListView *view = [[AppBridge instance] resolveView:[PlanListView class]];
        [service find:^(Result *result) {
            NSLog(@"%@", result);
        } limit:[Limit limitWithStart:0 size:-1] forClass:[GT_Plan class]];


        [view findAllPlans:^(Result *result) {
            NSLog(@"%@", result);
        }];

        [bridge shutdown:LC_ALL];

    }

    return 0;
}