#import "Query.h"

@interface Query ()

@property(strong) NSMutableArray *condtions;

@end

@implementation Query

- (instancetype)init {
    self = [super init];
    if (self) {
        self.condtions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (Condition *)add:(Condition *)condition {
    if (condition) {
        [self.condtions addObject:condition];
    }
    return condition;
}

- (NSArray *)conditions {
    return [self.condtions copy];
}


+ (instancetype)query {
    return [[self alloc] init];
}


@end