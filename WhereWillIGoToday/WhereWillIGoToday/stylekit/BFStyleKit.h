//
//  BFStyleKit.h
//  BF Customized Icons
//
//  Created by Thomas Strauß on 14.10.15.
//  Copyright (c) 2015 BeanFactory. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface BFStyleKit : NSObject

// Colors
+ (UIColor*)ausfallBase;
+ (UIColor*)ausfallFill;
+ (UIColor*)ausfallRand;
+ (UIColor*)ausfallText;
+ (UIColor*)ersatzBase;
+ (UIColor*)ersatzFill;
+ (UIColor*)ersatzRand;
+ (UIColor*)ersatzText;
+ (UIColor*)mitteilungBase;
+ (UIColor*)mitteilungFill;
+ (UIColor*)mitteilungRand;
+ (UIColor*)mitteilungText;
+ (UIColor*)offBase;
+ (UIColor*)offFill;
+ (UIColor*)offRand;
+ (UIColor*)offText;

// Drawing Methods
+ (void)drawBFSignalDotWithBulletFrame: (CGRect)bulletFrame title: (NSString*)title mode: (CGFloat)mode fontSize: (CGFloat)fontSize;

@end