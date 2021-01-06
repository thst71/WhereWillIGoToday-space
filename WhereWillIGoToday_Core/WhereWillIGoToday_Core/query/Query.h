#import <Foundation/Foundation.h>

#import "Condition.h"

@interface Query : NSObject


+ (instancetype)query;


- (Condition *)add:(Condition *)condition;

- (NSArray *)conditions;

@end