#import <Foundation/Foundation.h>

@class ModelDAO;

@interface DAOWrapper : NSObject

@property(strong) ModelDAO *offline;
@property(strong) ModelDAO *online;

- (instancetype)initWithOffline:(ModelDAO *)offline online:(ModelDAO *)online;

+ (instancetype)wrapperWithOffline:(ModelDAO *)offline online:(ModelDAO *)online;


@end