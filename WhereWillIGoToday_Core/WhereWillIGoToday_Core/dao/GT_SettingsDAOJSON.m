//
// Created by Thomas Strauß on 14.01.15.
// Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import "GT_SettingsDAOJSON.h"
#import "AppDebugger.h"
#import "Unmarshaller.h"
#import "GT_PlanList.h"


@interface GT_SettingsDAOJSON ()

@property NSArray *favorites;

@end

@implementation GT_SettingsDAOJSON

- (void)startup {
    NSString *_path = pathToSettings();

    if (!_path) {
        return;
    }

    if ([AppDebugger logEnabled]) {
        [AppDebugger log:[NSString stringWithFormat:@"lade Daten aus %@", _path]
                   where:_cmd];

    }

    NSError *error = nil;
    NSData *data = [[NSData alloc] initWithContentsOfFile:_path];
    if (data) {

        NSMutableArray *mutable = [NSMutableArray array];

        id <Unmarshaller> sM = [GT_PlanList unmarshaller];

        if (sM) {
            NSError *error = nil;
            [sM unmarshal:data into:mutable error:&error];

            if (error) {
                [AppDebugger log:[NSString stringWithFormat:@"parser-error %@",
                                                            [error description]]
                           where:_cmd];
            }
            else {
                // make immutable
                self.favorites = [NSArray arrayWithArray:mutable];
            }
        }
        else {
            [AppDebugger log:[NSString stringWithFormat:@"error %@",
                                                        [error description]]
                       where:_cmd];

        }
    }
}


- (void)find:(Callback)callback byKey:(NSString *)key {

    __block id result = nil;

    [self.favorites enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([[object key] isEqualToString:key]) {
            result = object;
            *stop = true;
        }
    }];

    forward(callback, result, false);
}

- (void)find:(Callback)callback limit:(Limit *)limit {
    [self find:callback query:nil limit:limit];
}


- (void)find:(Callback)callback query:(Query *)query limit:(Limit *)limit {
    NSArray *data = self.favorites;

    if(!data) {
        forward(callback, APP_ERROR_NO_DATA, true);
        return;
    }

    NSRange rng;
    if( limit.size == -1 ) {
        rng = NSMakeRange(0, data.count);
    }
    else if(limit.start < data.count) {
        if( limit.start + limit.size > data.count) {
            rng = NSMakeRange(limit.start, data.count - limit.start);
        }
        else {
            rng = NSMakeRange(limit.start, limit.size);
        }

    }
    else {
        forward(callback, APP_ERROR_BAD_RANGE, true);
    }

    NSArray *copy = [NSArray arrayWithArray:[data subarrayWithRange:rng]];

    forward(callback, copy, false);
}

@end