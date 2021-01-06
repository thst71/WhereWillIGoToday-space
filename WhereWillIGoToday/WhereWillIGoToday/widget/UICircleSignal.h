//
// Created by Thomas Strauß on 22.12.20.
// Copyright (c) 2020 Thomas Strauß. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UICircleSignal : UIView

@property(nonatomic) IBInspectable UIColor *signalColor;

- (instancetype)initWithSignalColor:(UIColor *)signalColor;

+ (instancetype)signalWithSignalColor:(UIColor *)signalColor;

@end
