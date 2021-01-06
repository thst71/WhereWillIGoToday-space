#import "Result.h"

@interface Result ()

@property(strong, readwrite) NSObject *data;
@property(readwrite) bool isError;

@end

@implementation Result

- (instancetype)initWithData:(NSObject *)data isError:(bool)isError {
    self = [super init];
    if (self) {
        self.data = data;
        self.isError = isError;
    }

    return self;
}

+ (instancetype)resultWithData:(NSObject *)data isError:(bool)isError {
    return [[self alloc] initWithData:data
                              isError:isError];
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ",
                                                                     NSStringFromClass([self class])];
    [description appendFormat:@" data=%@",
                              self.data];
    [description appendFormat:@", isError=%d",
                              self.isError];
    [description appendString:@">"];
    return description;
}


@end