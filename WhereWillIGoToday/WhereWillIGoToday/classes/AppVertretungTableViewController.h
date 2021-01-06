//
//  AppVertretungTableViewController.h
//  WhereWillIGoToday
//
//  Created by Thomas Strauß on 26.02.15.
//  Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppVertretungTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UINavigationItem *navigation;

@property(nonatomic, strong) NSArray *vertretungen;
@end
