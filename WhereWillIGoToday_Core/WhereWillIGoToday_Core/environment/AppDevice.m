#import "AppDevice.h"
#import "AppDebugger.h"
#import "AppEnvironment.h"
#import "Reachability.h"
#import "GTSettings.h"

@interface AppDevice ()
@property bool state;

- (void)toggle:(NSNotification *)notification;

@end

@implementation AppDevice

- (instancetype)init {
    self = [super init];
    if (self) {
        self.state = false;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(toggle:)
                                                     name:APP_NOTIFICATION_ONLINE_UPDATE
                                                   object:nil];
    }
    return self;
}

- (void)toggle:(NSNotification *)notification {
    [AppDebugger log:notification
               where:_cmd];
    self.state = !self.state;
}


//TODO Anbindung ans Device
- (bool)online {
    #ifdef SO_DEBUG
    return [Reachability reachabilityForInternetConnection] != nil;
    #else
    return [Reachability reachabilityForInternetConnection] != nil;
    #endif
}

- (GTSettings *)settings {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if([defaults arrayForKey:APP_KEY_SETTINGS_FAVORITES]) {
        return [GTSettings settingsWithDictionary:@{APP_KEY_SETTINGS_FAVORITES: [defaults arrayForKey:APP_KEY_SETTINGS_FAVORITES]}];
    }

    return [[GTSettings alloc] init];
}

-(void)addFavorite:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSMutableArray *favs;

    if([defaults arrayForKey:APP_KEY_SETTINGS_FAVORITES]) {
        favs = [NSMutableArray arrayWithArray:        [defaults arrayForKey:APP_KEY_SETTINGS_FAVORITES]];
    }
    else {
        favs = [NSMutableArray arrayWithCapacity:3];
    }

    if(![favs containsObject:key]) {
        [favs addObject:key];
        [defaults setObject:favs forKey:APP_KEY_SETTINGS_FAVORITES];
        [defaults synchronize];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end