//
// Created by Frank Bahn on 17.12.14.
// Copyright (c) 2014 fb-it-solutions GmbH. All rights reserved.
//

#import "LifecycleWrapper.h"
#import "AppDebugger.h"

@interface LifecycleWrapper ()

@property bool running;

@property(strong, readwrite) id <Lifecycle> i_startup;
@property(strong, readwrite) id <Lifecycle> i_shutdown;

@end

@implementation LifecycleWrapper

- (void)startup {
    if (self.running || !self.i_startup) {
        return;
    }
    [self.i_startup startup];
    if ([AppDebugger logEnabled]) {
        [AppDebugger log:[NSString stringWithFormat:@"startup %@ complete",
                                                    self.i_startup]
                   where:_cmd];

    }

    self.running = true;
}

- (void)shutdown {
    if (!self.running || !self.i_shutdown) {
        return;
    }
    [self.i_shutdown shutdown];
    if ([AppDebugger logEnabled]) {
        [AppDebugger log:[NSString stringWithFormat:@"shutdown %@ complete",
                                                    self.i_shutdown]
                   where:_cmd];

    }
    self.running = false;
}

- (instancetype)initWithLifecycle:(id <Lifecycle>)lifecycle {
    self = [super init];
    if (self) {
        if ([lifecycle respondsToSelector:@selector(startup)]) {
            self.i_startup = lifecycle;
        }
        if ([lifecycle respondsToSelector:@selector(shutdown)]) {
            self.i_shutdown = lifecycle;
        }
    }

    return self;
}

+ (instancetype)lifecycleWrapperWithLifecycle:(id <Lifecycle>)lifecycle {
    return [[self alloc] initWithLifecycle:lifecycle];
}

@end