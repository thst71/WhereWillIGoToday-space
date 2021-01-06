#import <Foundation/Foundation.h>

@interface Result : NSObject

@property(strong, readonly) NSObject *data;
@property(readonly) bool isError;

- (instancetype)initWithData:(NSObject *)data isError:(bool)isError;

- (NSString *)description;

+ (instancetype)resultWithData:(NSObject *)data isError:(bool)isError;


@end