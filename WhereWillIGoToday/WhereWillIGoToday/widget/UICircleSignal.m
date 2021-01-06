//
// Created by Thomas Strauß on 22.12.20.
// Copyright (c) 2020 Thomas Strauß. All rights reserved.
//

#import "UICircleSignal.h"

IB_DESIGNABLE

@implementation UICircleSignal

- (instancetype)init {
    self = [super init];
    if (self) {
        self.signalColor = [UIColor redColor];
    }

    return self;
}




- (instancetype)initWithSignalColor:(UIColor *)signalColor {
    self = [super init];
    if (self) {
        self.signalColor = signalColor;
    }

    return self;
}

+ (instancetype)signalWithSignalColor:(UIColor *)signalColor {
    return [[self alloc] initWithSignalColor:signalColor];
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *p = [UIBezierPath bezierPathWithOvalInRect:rect];
    [self.signalColor setFill];
    [p fill];
}

@end