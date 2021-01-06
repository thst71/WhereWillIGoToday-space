//
// Created by Frank Bahn on 17.12.14.
// Copyright (c) 2014 fb-it-solutions GmbH. All rights reserved.
//

#import "AppBridge.h"
#import "ModelView.h"
#import "LifecycleManager.h"
#import "AppDebugger.h"
#import "GT_PlanDAOJSON.h"
#import "GT_PlanDAONetwork.h"
#import "GT_Plan.h"
#import "PlanListView.h"
#import "GT_SettingsDAOJSON.h"
#import "GT_Settings.h"

static AppBridge *instance;
static LC_Type LC_ORDER[3];

@interface AppBridge ()

@property(strong) LifecycleManager *lifecycleManager;
@property(strong, readwrite) AppService *appService;
@property(strong) AppDevice *appDevice;

@property dispatch_queue_t queue;

@property(strong) NSMutableDictionary *views;

@end


@implementation AppBridge


- (void)registerView:(ModelView *)view {
    if (!view) {
        return;
    }
    self.views[dkey([view class])] = view;
}

- (ModelView *)resolveView:(Class)clazz {
    if (!clazz) {
        return nil;
    }
    return self.views[dkey(clazz)];
}


- (void)startup:(LC_Type)type {
    if ([type isEqualToString:LC_All]) {
        for (int i = 0; i < 3; i++) {
            [self.lifecycleManager startup:LC_ORDER[i]];
        }
    }
    else {
        [self.lifecycleManager startup:type];
    }
}

- (void)shutdown:(LC_Type)type {
    if ([type isEqualToString:LC_All]) {
        for (int i = 2; i >= 0; i--) {
            [self.lifecycleManager shutdown:LC_ORDER[i]];
        }
    }
    else {
        [self.lifecycleManager shutdown:type];
    }
}


+ (AppBridge *)instance {
    @synchronized (self) {
        if (instance == nil) {
            instance = [[self alloc] init];

            @autoreleasepool {

                LC_ORDER[0] = LC_DAO;
                LC_ORDER[1] = LC_SERVICE;
                LC_ORDER[2] = LC_VIEW;

                NSString *DATAFILE = @"plan";
                NSString *EXTENSION = @"json";

                NSString *source = [[NSBundle mainBundle] pathForResource:DATAFILE
                                                                   ofType:EXTENSION];
                if (source) {
                    [AppDebugger log:source
                               where:_cmd];

                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
                    NSString *destination = [documents stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",
                                                                                                                 DATAFILE,
                                                                                                                 EXTENSION]];
                    if (![fileManager fileExistsAtPath:destination]) {

                        NSError *error = nil;

                        NSData *data = [NSData dataWithContentsOfFile:source
                                                              options:NSDataReadingMapped
                                                                error:&error];

                        [fileManager createFileAtPath:destination
                                             contents:data
                                           attributes:nil];

                    }
                }
            }

            instance.queue = dispatch_queue_create(QUEUE_NAME, NULL);

            instance.views = [[NSMutableDictionary alloc] init];

            LifecycleManager *lifecycleManager = [[LifecycleManager alloc] init];
            instance.lifecycleManager = lifecycleManager;

            instance.appDevice = [[AppDevice alloc] init];

            AppService *appService = [[AppService alloc] initWithDevice:instance.appDevice];
            instance.appService = appService;

            [lifecycleManager add:appService
                              for:LC_SERVICE];


            // Add DAOs

            ModelDAO *online = [[GT_PlanDAONetwork alloc] init];
            ModelDAO *offline = [[GT_PlanDAOJSON alloc] init];

            //[[StationDAOMock alloc] init];

            [lifecycleManager add:online
                              for:LC_DAO];

            [lifecycleManager add:offline
                              for:LC_DAO];

            DAOWrapper *wrapper = [DAOWrapper wrapperWithOffline:offline
                                                          online:online];

            [appService register:wrapper
                        forClass:[GT_Plan class]];

            // add settings
            online = [[GT_SettingsDAOJSON alloc] init];

            [lifecycleManager add:online for:LC_DAO];

            wrapper = [DAOWrapper wrapperWithOffline:online
                                              online:online];

            [appService register:wrapper
                        forClass:[GT_Settings class]];

            // views

            PlanListView *planListView = [[PlanListView alloc] init];

            [lifecycleManager add:planListView for:LC_VIEW];

            [instance registerView:planListView];

            instance.appService = appService;

            // startup
        }
    }
    return instance;
}

- (dispatch_queue_t)defaultQueue {
    return self.queue;
}

- (bool)online {
    if (!self.appDevice) {
        return false;
    }
    return self.appDevice.online;
}


@end
