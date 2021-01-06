//
// Created by Frank Bahn on 17.12.14.
// Copyright (c) 2014 fb-it-solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Lifecycle.h"

@interface LifecycleWrapper : NSObject

- (void)startup;

- (void)shutdown;

- (instancetype)initWithLifecycle:(id <Lifecycle>)lifecycle;

+ (instancetype)lifecycleWrapperWithLifecycle:(id <Lifecycle>)lifecycle;


@end