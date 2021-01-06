//
// Created by Frank Bahn on 17.12.14.
// Copyright (c) 2014 fb-it-solutions GmbH. All rights reserved.
//

#import "AppDebugger.h"


@implementation AppDebugger

+ (bool)logEnabled {
    return true;
}


+ (void)log:(id)object where:(SEL)where {
    if (!object || ![self logEnabled]) {
        return;
    }
    NSLog(@"%@ - %@", object, NSStringFromSelector(where));
}


@end