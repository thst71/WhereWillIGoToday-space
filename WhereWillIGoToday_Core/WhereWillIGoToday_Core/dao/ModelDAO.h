#import <Foundation/Foundation.h>
#import "AppEnvironment.h"

#import "Model.h"
#import "Limit.h"
#import "Query.h"
#import "Lifecycle.h"

@interface ModelDAO : NSObject <Lifecycle>

- (void)persist:(Callback)callback model:(Model *)model;

- (void)find:(Callback)callback byKey:(NSString *)key;

- (void)find:(Callback)callback limit:(Limit *)limit;

- (void)find:(Callback)callback query:(Query *)query limit:(Limit *)limit;

@end