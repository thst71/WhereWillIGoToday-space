#import "Limit.h"

@interface Limit ()

@property(readwrite) NSUInteger start;
@property(readwrite) NSUInteger size;

@end

@implementation Limit

- (instancetype)initWithStart:(NSUInteger)start size:(NSUInteger)size {
    self = [super init];
    if (self) {
        self.start = start;
        self.size = size;
    }

    return self;
}

+ (instancetype)limitWithStart:(NSUInteger)start size:(NSUInteger)size {
    return [[self alloc] initWithStart:start
                                  size:size];
}


@end