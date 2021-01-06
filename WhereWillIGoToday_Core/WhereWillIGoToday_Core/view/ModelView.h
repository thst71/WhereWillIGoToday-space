#import <Foundation/Foundation.h>

#import "AppEnvironment.h"
#import "Model.h"
#import "Limit.h"
#import "Query.h"
#import "Lifecycle.h"

@class AppService;

@interface ModelView : NSObject <Lifecycle>

@property(strong) Class supports;
@property(strong, readonly) AppService *appService;

@property(strong) NSMutableDictionary *cache;

- (instancetype)initWithSupports:(Class)supports;

+ (instancetype)viewWithSupports:(Class)supports;


- (void)persist:(Callback)callback model:(Model *)model;

- (void)find:(Callback)callback byKey:(NSString *)key;

- (void)find:(Callback)callback limit:(Limit *)limit;

- (void)find:(Callback)callback query:(Query *)query limit:(Limit *)limit;


@end