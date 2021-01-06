//
//  BFSignalBar.m
//  WhereWillIGoToday
//
//  Created by Thomas Strauß on 14.10.15.
//  Copyright © 2015 Thomas Strauß. All rights reserved.
//

#import "BFSignalBar.h"
#import "BFSignalDotView.h"

@interface BFSignalBar ()
@property(nonatomic, strong) NSMutableArray *signals;
@end

@implementation BFSignalBar


- (instancetype)init {
    self = [super init];
    if (self) {
        self.signals = [NSMutableArray arrayWithCapacity:10];

    }

    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    if (self.signals.count) {
        for (BFSignalDotView* sdv in self.signals) {
            [sdv removeFromSuperview];
            [self addSubview:sdv];
        }
    }
}
*/

- (void)addSignal:(NSString *)title withMode:(CGFloat)mode {
    UIView *sdv = [BFSignalDotView signalDotViewWithTitle:title andMode:mode];
//    [self.signals addObject:sdv];
    NSUInteger subcount = self.subviews.count;
    sdv.translatesAutoresizingMaskIntoConstraints = NO;
    //sdv.frame = CGRectMake(subcount * 30 + 5, 1, 22, 22);
    sdv.backgroundColor = [UIColor whiteColor];

    
    NSDictionary *_views;
    
    if(self.subviews.count) {
        UIView *previous = [self.subviews lastObject];
        UIView *first = [self.subviews firstObject];
        
        _views = NSDictionaryOfVariableBindings(first, previous, sdv);
    }
    else {
        _views = NSDictionaryOfVariableBindings(sdv);
    }
    
    [self addSubview:sdv];

    NSUInteger rowsize = floorf(self.bounds.size.width / 27);
    NSLog(@"width: %f rowsize: %lul", self.bounds.size.width, (unsigned long)rowsize);
    
    if(self.subviews.count == 1 || self.subviews.count == rowsize  ) {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5.0-[sdv(22.0)]"
                                                                     options:NSLayoutFormatAlignAllBottom
                                                                     metrics:nil
                                                                       views:_views]
         ];
    }
    else {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[previous]-5.0-[sdv(22.0)]"
                                                                     options:NSLayoutFormatAlignAllBottom
                                                                     metrics:nil
                                                                       views:_views]
         ];
    }
    
    if(self.subviews.count < rowsize) {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-1.0-[sdv(22.0)]"
                                                                     options:NSLayoutFormatAlignAllBottom
                                                                     metrics:nil
                                                                       views:_views]
         ];
    }
    else {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-27.0-[sdv(22.0)]"
                                                                     options:NSLayoutFormatAlignAllBottom
                                                                     metrics:nil
                                                                       views:_views]
         ];
    }

    
    
//    [self setNeedsDisplay];
//    [self setNeedsLayout];

}

- (void)clearSignals {

    for(UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
    
}

- (void) centerSignals {
    NSUInteger subcount = self.subviews.count;
    NSLog(@"%@", NSStringFromCGRect(self.frame));
    CGFloat whitespace = (self.frame.size.width  - (subcount * 35 - 5));
    CGFloat left = whitespace / 2;
    NSUInteger offset = ceilf(left);
    if( offset <= 0 ) {
        return;
    }
    
    for(UIView *v in self.subviews) {
        NSLog(@"%@", NSStringFromCGRect(v.frame));
        v.frame = CGRectMake(v.frame.origin.x + offset, 1, v.frame.size.width, v.frame.size.height);
    }
}

@end
