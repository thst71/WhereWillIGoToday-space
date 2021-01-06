//
//  Created by Cocoa JSON Editor
//  http://www.cocoajsoneditor.com
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

@interface GT_Plan : Model

@property (assign, nonatomic) NSUInteger pages;
@property (strong, nonatomic) NSArray *motd;
@property (strong, nonatomic) NSArray *entries;

- (id) initWithJSONDictionary:(NSDictionary *)dic;
- (void) parseJSONDictionary:(NSDictionary *)dic;

+ (id)planWithKey:(NSString *)string andMotd:(NSString *)motd;

- (NSString *)description;

@end
