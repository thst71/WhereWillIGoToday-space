#import "ModelView.h"
#import "AppService.h"
#import "AppBridge.h"

@interface ModelView ()

@property(strong, readwrite) AppService *appService;

@end

@implementation ModelView

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithSupports:(Class)supports {
    self = [self init];
    if (self) {
        self.supports = supports;
    }

    return self;
}

+ (instancetype)viewWithSupports:(Class)supports {
    return [[self alloc] initWithSupports:supports];
}


- (void)persist:(Callback)callback model:(Model *)model {
    //TODO  hier erfolgen Überprüfungen auf 'Vollständigkeit' des 'Models'
    [self.appService persist:callback
                       model:model];
}

- (void)find:(Callback)callback byKey:(NSString *)key {
    [self.appService find:callback
                    byKey:key
                 forClass:self.supports];
}


- (void)find:(Callback)callback limit:(Limit *)limit {
    [self.appService find:callback
                    limit:limit
                 forClass:self.supports];
}

- (void)find:(Callback)callback query:(Query *)query limit:(Limit *)limit {
    [self.appService find:callback
                    query:query
                    limit:limit
                 forClass:self.supports];
}

- (void)startup {
    id appBridge = [AppBridge instance];
    self.appService = [appBridge appService];
    self.cache = [NSMutableDictionary dictionary];
}

- (void)shutdown {

}


@end