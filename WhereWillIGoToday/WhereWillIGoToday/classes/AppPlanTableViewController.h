//
//  AppPlanTableViewController.h
//  WhereWillIGoToday
//
//  Created by Thomas Strauß on 23.02.15.
//  Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppService;

@interface AppPlanTableViewController : UITableViewController

@property(nonatomic, strong) NSArray *planlist;
@property(nonatomic, strong) NSArray *statelist;
@property(nonatomic, strong) NSArray *favorites;
@end
