#import "DAOWrapper.h"
#import "ModelDAO.h"

@implementation DAOWrapper
- (instancetype)initWithOffline:(ModelDAO *)offline online:(ModelDAO *)online {
    self = [super init];
    if (self) {
        self.offline = offline;
        self.online = online;
    }

    return self;
}

+ (instancetype)wrapperWithOffline:(ModelDAO *)offline online:(ModelDAO *)online {
    return [[self alloc] initWithOffline:offline
                                  online:online];
}

@end