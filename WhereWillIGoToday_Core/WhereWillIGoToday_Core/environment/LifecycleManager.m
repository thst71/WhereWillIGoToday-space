#import "LifecycleManager.h"
#import "Lifecycle.h"
#import "LifecycleWrapper.h"

@interface LifecycleManager ()

@property(strong) NSMutableDictionary *data;

@property(strong) NSArray *up;
@property(strong) NSArray *down;

@end

@implementation LifecycleManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.data = [[NSMutableDictionary alloc] init];

        self.data[LC_DAO] = [[NSMutableArray alloc] init];
        self.data[LC_SERVICE] = [[NSMutableArray alloc] init];
        self.data[LC_VIEW] = [[NSMutableArray alloc] init];

        self.up = @[
                LC_DAO,
                LC_SERVICE,
                LC_VIEW
        ];

        self.down = @[
                LC_VIEW,
                LC_SERVICE,
                LC_DAO
        ];
    }

    return self;
}


- (void)startup:(LC_Type)type {
    if (type) {
        NSArray *array = self.data[type];
        [array enumerateObjectsUsingBlock:^(id lifecycle, NSUInteger index, BOOL *stop) {
            [lifecycle startup];
        }];
    }
    else {
        [self.up enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            NSArray *array = self.data[object];
            [array enumerateObjectsUsingBlock:^(id lifecycle, NSUInteger index, BOOL *stop) {
                [lifecycle startup];
            }];
        }];
    }
}

- (void)shutdown:(LC_Type)type {
    if (type) {
        NSArray *array = self.data[type];
        [array enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            [object shutdown];
        }];
    }
    else {
        [self.down enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            NSArray *array = self.data[object];
            [array enumerateObjectsUsingBlock:^(id lifecycle, NSUInteger index, BOOL *stop) {
                [lifecycle shutdown];
            }];
        }];
    }
}

- (void)add:(id <Lifecycle>)lifecycle for:(LC_Type)type {
    if (!lifecycle || !type) {
        return;
    }

    [self.data[type] addObject:[LifecycleWrapper lifecycleWrapperWithLifecycle:lifecycle]];

}


@end