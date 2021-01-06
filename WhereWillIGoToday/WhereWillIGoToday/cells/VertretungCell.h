//
//  VertretungCell.h
//  WhereWillIGoToday
//
//  Created by Thomas Strauß on 26.02.15.
//  Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICircleSignal.h"

@interface VertretungCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *Stunde;
@property (weak, nonatomic) IBOutlet UILabel *Fach;
@property (weak, nonatomic) IBOutlet UILabel *FachNeu;
@property (weak, nonatomic) IBOutlet UILabel *Lehrer;
@property (weak, nonatomic) IBOutlet UILabel *LehrerNeu;
@property (weak, nonatomic) IBOutlet UILabel *Raum;
@property (weak, nonatomic) IBOutlet UILabel *Art;
@property (weak, nonatomic) IBOutlet UILabel *Bemerkung;
@property (weak, nonatomic) IBOutlet UILabel *Titlebar;
@property (weak, nonatomic) IBOutlet UICircleSignal *Signal;

+(NSString*)identifier;

- (void)applyPlanEntry:(GT_PlanEntry *)entry;
@end
