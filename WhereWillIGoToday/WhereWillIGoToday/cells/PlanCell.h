//
// Created by Thomas Strauß on 23.02.15.
// Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanCell : UITableViewCell

@property(weak,nonatomic) IBOutlet UILabel*title;


+(NSString*)identifier;

@end

/**
* Header Cell is used if the TV request a section cell with row 0
*/

@interface HeaderCell : UITableViewCell

@property(weak,nonatomic) IBOutlet UILabel*title;
@property (weak, nonatomic) IBOutlet UILabel *motd;
@property (weak, nonatomic) IBOutlet UILabel *todayMarker;


+(NSString*)identifier;

@end