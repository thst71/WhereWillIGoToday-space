//
// Created by Frank Bahn on 17.12.14.
// Copyright (c) 2014 fb-it-solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Lifecycle <NSObject>

@optional
- (void)startup;

- (void)shutdown;

@end