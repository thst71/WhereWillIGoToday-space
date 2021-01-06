//
//  VertretungCell.m
//  WhereWillIGoToday
//
//  Created by Thomas Strauß on 26.02.15.
//  Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import <WhereWillIGoTodayCore/GT_PlanEntry.h>
#import "VertretungCell.h"

#define COLOR_OF_ENTFALL UIColor.orangeColor
#define COLOR_OF_ALL_THE_REST UIColor.greenColor

@implementation VertretungCell

+(NSString *)identifier {
    return @"vertretungcell";
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)applyPlanEntry:(GT_PlanEntry *)entry {
    self.Art.text = entry.Art;
    self.Bemerkung.text = entry.Bemerkung;
    self.Fach.text = entry.Fach;
    self.FachNeu.text = entry.Fach == entry.NeuFach ? @"" : entry.NeuFach;
    self.Lehrer.text = [self decideLehrer:entry];
    self.LehrerNeu.text = [self decideVertreter:entry];
    self.Raum.text = entry.PlanRaum;
    self.Stunde.text = entry.Stunde;

    [self fixLehrerAndFach];

    [self applyColors:entry];
}

- (void)applyColors:(GT_PlanEntry *)entry {

    if([entry.Art.uppercaseString isEqualToString:@"ENTFALL"]) {
        self.Signal.signalColor = [UIColor colorWithHue:0 saturation:0.47 brightness:0.9 alpha:1];
    }
    else {
        self.Signal.signalColor = [UIColor colorWithHue:0.45 saturation:0.8 brightness:0.6 alpha:0.8];
    }
}

- (void)fixLehrerAndFach {
    if( self.FachNeu.text.length + self.LehrerNeu.text.length == 0) {
        self.FachNeu.text = self.Fach.text;
        self.LehrerNeu.text = self.Lehrer.text;
        self.Fach.text = @"";
        self.Lehrer.text = @"";
    }
}

- (NSString *)decideLehrer:(GT_PlanEntry *)entry {
    NSLog(@"PL: %@  VL: %@  F:%@", entry.PlanLehrer, entry.NeuVertreter, entry.Fach);
    if(entry.NeuVertreter == entry.PlanLehrer && entry.Fach.length == 0) {
        return @"";
    }
    return entry.PlanLehrer;
}

- (NSString *)decideVertreter:(GT_PlanEntry *)entry {
    NSLog(@"PL: %@  VL: %@  F:%@", entry.PlanLehrer, entry.NeuVertreter, entry.Fach);
    if(entry.NeuVertreter == entry.PlanLehrer && entry.Fach.length != 0) {
        return @"";
    }
    return entry.NeuVertreter;
}

@end
