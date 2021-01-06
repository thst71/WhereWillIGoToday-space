#import <Foundation/Foundation.h>

@class GTSettings;

@interface AppDevice : NSObject

- (bool)online;

-(GTSettings*)settings;

- (void)addFavorite:(NSString *)key;
@end