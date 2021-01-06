//
//  BFSignalDotView.h
//  WhereWillIGoToday
//
//  Created by Thomas Strauß on 13.10.15.
//  Copyright © 2015 Thomas Strauß. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BFStyleKit.h"

#define BF_SIGNAL_MODE_OFF 3
#define BF_SIGNAL_MODE_AUSFALL 2
#define BF_SIGNAL_MODE_ERSATZ 1
#define BF_SIGNAL_MODE_MITTEILUNG 0

@interface BFSignalDotView : UIView

@property(nonatomic) CGFloat modeid;
@property(nonatomic) NSString *fach;

+ (instancetype)signalDotViewWithTitle:(NSString *)title andMode:(CGFloat)mode;

@end
