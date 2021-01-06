#import <Foundation/Foundation.h>
#import "AppService.h"

@class ModelView;


@interface AppBridge : NSObject

@property(strong, readonly) AppService *appService;


- (void)registerView:(ModelView *)view;

- (ModelView *)resolveView:(Class)clazz;

- (void)startup:(LC_Type)type;

- (void)shutdown:(LC_Type)type;

- (bool)online;

- (dispatch_queue_t)defaultQueue;

+ (AppBridge *)instance;


@end