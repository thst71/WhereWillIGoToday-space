#import <Foundation/Foundation.h>

@interface Model : NSObject

@property(strong) NSString *key;
@property(strong) NSDate *created;
@property(strong) NSDate *modified;

- (instancetype)initWithKey:(NSString *)key created:(NSDate *)created modified:(NSDate *)modified;

- (NSString *)description;

+ (instancetype)modelWithKey:(NSString *)key created:(NSDate *)created modified:(NSDate *)modified;


@end