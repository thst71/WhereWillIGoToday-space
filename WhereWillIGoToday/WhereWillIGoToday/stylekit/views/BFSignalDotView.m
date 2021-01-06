//
//  BFSignalDotView.m
//  WhereWillIGoToday
//
//  Created by Thomas Strauß on 13.10.15.
//  Copyright © 2015 Thomas Strauß. All rights reserved.
//

#import "BFSignalDotView.h"

@implementation BFSignalDotView


+(instancetype)signalDotViewWithTitle:(NSString *)title andMode:(CGFloat)mode {
    BFSignalDotView *view = [[BFSignalDotView alloc] init];
    view.fach = title;
    view.modeid = mode;
    
    return view;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    NSLog(@"self.bounds: %@", NSStringFromCGRect(self.bounds));
    NSLog(@"rect: %@", NSStringFromCGRect(rect));
    
    CGFloat initialExpectedFontSize = (rect.size.width * 0.5);
    CGFloat expectedFontSize = initialExpectedFontSize;
    CGFloat allowedWidth = rect.size.width * 0.8;
    
    CGSize size = [self.fach sizeWithAttributes:
                   @{NSFontAttributeName: [UIFont systemFontOfSize:expectedFontSize]}];
    
    
    NSString * fach = self.fach;
    
    if(size.width > allowedWidth) {
        CGFloat diff = allowedWidth / size.width;
        
        expectedFontSize = diff * expectedFontSize;
        
        if( expectedFontSize < 5 ) {
            fach = [fach substringToIndex:3];
            expectedFontSize = 8;
        }
    }
    
    [BFStyleKit drawBFSignalDotWithBulletFrame:rect title:fach mode:self.modeid fontSize:expectedFontSize];
    
}

@end
