#import <Foundation/Foundation.h>

@interface AppDebugger : NSObject

+ (bool)logEnabled;

+ (void)log:(id)object where:(SEL)where;

@end