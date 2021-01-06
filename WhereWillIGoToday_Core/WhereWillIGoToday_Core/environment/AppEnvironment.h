#import <Foundation/Foundation.h>

#import "Result.h"

static NSString *APP_NOTIFICATION_ONLINE_UPDATE = @"UpdateOnlineState";

static NSString *APP_ERROR_NIL = @"nil nicht erlaubt";
static NSString *APP_ERROR_NO_DAO = @"dao nicht gefunden";
static NSString *APP_ERROR_NO_DATA = @"keine Daten vom Server";
static NSString *APP_ERROR_NO_WRAPPER = @"wrapper nicht gefunden";
static NSString *APP_ERROR_BAD_RANGE = @"Limit kann nicht angewendet werden";
static NSString *APP_INFO_NOT_IMPLEMENTED = @"Methode nicht implementiert";

static NSString *APP_EMPTY = @"";

static NSString *APP_KEY_KEY = @"key";
static NSString *APP_KEY_NAME = @"name";
static NSString *APP_KEY_CREATED = @"created";
static NSString *APP_KEY_MODIFIED = @"modified";
static NSString *APP_KEY_LATITUDE = @"latitude";
static NSString *APP_KEY_LONGITUDE = @"longitude";
static NSString *APP_KEY_COORDINATE = @"coordinate";
static NSString *APP_KEY_WIND = @"wind";
static NSString *APP_KEY_DIRECTION = @"direction";
static NSString *APP_KEY_STRENGTH = @"strength";
static NSString *APP_KEY_SETTINGS_FAVORITES = @"favorites";



static NSString *APP_KEY_SELECTED_STATION = @"APP_KEY_SELECTED_STATION";

static char *const QUEUE_NAME = "de.beanfactory.queue.DefaultQueue";

/* Settings Preference Keys */
static NSString *APP_SETTING_SERVERURL = @"http://nullpunktzwei.de/plan.json";
//static NSString *APP_SETTING_SERVERURL = @"http://localhost:8080/plan.json";
static NSString *APP_SETTING_ONLYWLAN = @"wlan_only_preference";
static NSString *APP_SETTING_KLASSE = @"klasse_preference";
static NSString *APP_SETTING_ZUG = @"zug_preference";



typedef void (^Callback)(Result *);

typedef NSString *LC_Type;

static const LC_Type LC_All =  @"ALL";
static const LC_Type LC_DAO = @"DAO";
static const LC_Type LC_SERVICE = @"SERVICE";
static const LC_Type LC_VIEW = @"VIEW";

NSDate *convert(NSUInteger);

void forward(Callback, NSObject *, bool);

NSString *notImplemented(NSObject *, SEL);

NSString *dkey(Class);

id get(NSDictionary *, id <NSCopying>);

NSString *string(id);

NSString * path();

NSString * pathToSettings();

