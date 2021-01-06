//
//  AppKlassenTableViewController.h
//  WhereWillIGoToday
//
//  Created by Thomas Strauß on 24.02.15.
//  Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WhereWillIGoTodayCore/WhereWillIGoToday_Core.h>

@interface AppKlassenTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UINavigationItem *navbar;

@property(strong, nonatomic) GT_Plan *plan;

@end
