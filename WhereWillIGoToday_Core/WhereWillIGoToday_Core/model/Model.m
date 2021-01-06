#import "Model.h"


@interface Model ()


@end

@implementation Model

- (instancetype)initWithKey:(NSString *)key created:(NSDate *)created modified:(NSDate *)modified {
    self = [super init];
    if (self) {
        self.key = key;
        self.created = created;
        self.modified = modified;
    }

    return self;
}

+ (instancetype)modelWithKey:(NSString *)key created:(NSDate *)created modified:(NSDate *)modified {
    return [[self alloc] initWithKey:key
                             created:created
                            modified:modified];
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.key=%@", self.key];
    [description appendFormat:@", self.created=%@", self.created];
    [description appendFormat:@", self.modified=%@", self.modified];
    [description appendString:@">"];
    return description;
}


@end