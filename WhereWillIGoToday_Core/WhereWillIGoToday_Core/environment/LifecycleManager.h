#import <Foundation/Foundation.h>
#import "AppEnvironment.h"

@protocol Lifecycle;

@interface LifecycleManager : NSObject

- (void)startup:(LC_Type)type;

- (void)shutdown:(LC_Type)type;

- (void)add:(id <Lifecycle>)lifecycle for:(LC_Type)type;

@end