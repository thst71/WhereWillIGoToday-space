#import "AppService.h"
#import "ModelDAO.h"

@interface AppService ()

@property(strong) NSMutableDictionary *wrappers;
@property(strong, readwrite) AppDevice *appDevice;

- (ModelDAO *)dao:(Callback)callback forClass:(Class)clazz;

@end

@implementation AppService

- (instancetype)init {
    self = [super init];
    if (self) {
        self.wrappers = [[NSMutableDictionary alloc] init];

    }
    return self;
}

- (instancetype)initWithDevice:(AppDevice *)device {
    self = [self init];
    if (self) {
        _device = device;
    }
    return self;
}

- (ModelDAO *)dao:(Callback)callback forClass:(Class)clazz {
    DAOWrapper *daoWrapper = self.wrappers[dkey(clazz)];
    if (!daoWrapper) {
        forward(callback, APP_ERROR_NO_WRAPPER, true);
        return nil;
    }
    ModelDAO *modelDAO = nil;
    if (self.device.online) {
        modelDAO = daoWrapper.online;
    }
    else {
        modelDAO = daoWrapper.offline;
    }
    if (!modelDAO) {
        forward(callback, APP_ERROR_NO_DAO, true);
        return nil;
    }
    return modelDAO;
}

- (void)persist:(Callback)callback model:(Model *)model {
    if (!model) {
        forward(callback, APP_ERROR_NIL, true);
        return;
    }
    ModelDAO *modelDAO = [self dao:callback
                          forClass:[model class]];
    if (modelDAO) {
        [modelDAO persist:callback
                    model:model];
    }
}

- (void)find:(Callback)callback byKey:(NSString *)key forClass:(Class)clazz {
    ModelDAO *modelDAO = [self dao:callback
                          forClass:clazz];
    if (modelDAO) {
        [modelDAO find:callback
                 byKey:key];
    }
}

- (void)find:(Callback)callback limit:(Limit *)limit forClass:(Class)clazz {
    ModelDAO *modelDAO = [self dao:callback
                          forClass:clazz];
    if (modelDAO) {
        [modelDAO find:callback
                 limit:limit];
    }
}

- (void)find:(Callback)callback query:(Query *)query limit:(Limit *)limit forClass:(Class)clazz {
    ModelDAO *modelDAO = [self dao:callback
                          forClass:clazz];
    if (modelDAO) {
        [modelDAO find:callback
                 query:query
                 limit:limit];
    }
}

- (DAOWrapper *)register:(DAOWrapper *)wrapper forClass:(Class)clazz {
    if (!wrapper || !clazz) {
        return nil;
    }

    self.wrappers[dkey(clazz)] = wrapper;

    return wrapper;
}

- (void)startup {

}

- (void)shutdown {

}


+ (instancetype)serviceWithDevice:(AppDevice *)device {
    return [[self alloc] initWithDevice:device];
}


@end