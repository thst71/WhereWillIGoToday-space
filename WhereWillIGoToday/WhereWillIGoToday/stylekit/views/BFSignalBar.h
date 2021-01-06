//
//  BFSignalBar.h
//  WhereWillIGoToday
//
//  Created by Thomas Strauß on 14.10.15.
//  Copyright © 2015 Thomas Strauß. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BFSignalBar : UIView

- (void) addSignal:(NSString*)title withMode:(CGFloat)mode;

- (void) clearSignals;
- (void) centerSignals;

@end
