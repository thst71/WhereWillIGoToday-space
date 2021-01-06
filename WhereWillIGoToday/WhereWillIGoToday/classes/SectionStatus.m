//
// Created by Thomas Strauß on 23.02.15.
// Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import "SectionStatus.h"


@implementation SectionStatus {

}

- (id)init {
    self = [super init];
    if (self) {
    }

    return self;
}

- (instancetype)initWithOpen:(BOOL)open {
    self = [super init];
    if (self) {
        self.open = open;
    }

    return self;
}

+ (instancetype)statusWithOpen:(BOOL)open {
    return [[self alloc] initWithOpen:open];
}


@end