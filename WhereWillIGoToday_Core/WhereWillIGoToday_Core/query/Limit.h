#import <Foundation/Foundation.h>

@interface Limit : NSObject

@property(readonly) NSUInteger start;
@property(readonly) NSUInteger size;

- (instancetype)initWithStart:(NSUInteger)start size:(NSUInteger)size;

+ (instancetype)limitWithStart:(NSUInteger)start size:(NSUInteger)size;


@end