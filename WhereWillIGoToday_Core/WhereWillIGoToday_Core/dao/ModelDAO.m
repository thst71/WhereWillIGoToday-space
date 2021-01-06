#import "ModelDAO.h"

@implementation ModelDAO

- (void)persist:(Callback)callback model:(Model *)model {
    forward(callback, notImplemented(self, _cmd), true);
}

- (void)find:(Callback)callback byKey:(NSString *)key {
    forward(callback, notImplemented(self, _cmd), true);
}

- (void)find:(Callback)callback limit:(Limit *)limit {
    forward(callback, notImplemented(self, _cmd), true);
}

- (void)find:(Callback)callback query:(Query *)query limit:(Limit *)limit {
    forward(callback, notImplemented(self, _cmd), true);
}


@end