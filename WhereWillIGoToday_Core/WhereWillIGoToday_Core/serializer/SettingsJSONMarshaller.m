//
// Created by Thomas Strauß on 16.10.15.
// Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import "SettingsJSONMarshaller.h"
#import "AppDebugger.h"


@implementation SettingsJSONMarshaller {

}


- (void)unmarshal:(NSData *)data into:(id)target error:(NSError **)error {
    if (!target) {
        [AppDebugger log:@"target (NSMutableDictionary) not set (is nil)"
                   where:_cmd];

        *error = [NSError errorWithDomain:@"de.beanfactory.settings"
                                     code:-1
                                 userInfo:@{NSLocalizedDescriptionKey : @"target (NSMutableDictionary) not set (is nil)"}];
        return;
    }

    if (![target isKindOfClass:[NSMutableDictionary class]]) {
        [AppDebugger log:[NSString stringWithFormat:@"target is not of kind NSMutableDictionary. %@", [target class]]
                   where:_cmd];
        *error = [NSError errorWithDomain:@"de.beanfactory.settings"
                                     code:-2
                                 userInfo:@{NSLocalizedDescriptionKey : [NSString stringWithFormat:@"target is not of kind NSMutableDictionary. %@", [target class]]}];
        return;
    }

    NSMutableDictionary *settings = target;

    if (data) {

        id json = [NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingAllowFragments
                                                    error:error];

        if (json && [json isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dictionary = json;

            GT_Settings *setting = [[GT_Settings alloc] initWithJSONDictionary:dictionary];
            if (setting) {
                settings[@"settings"] = setting;
            }
            else {
                *error = [NSError errorWithDomain:@"de.beanfactory.plan"
                                             code:-3
                                         userInfo:@{NSLocalizedDescriptionKey : [NSString stringWithFormat:@"cannot parse index %ld: %@", (unsigned long) index, json]}];
            }
        }
        else {
            [AppDebugger log:[NSString stringWithFormat:@"error %@",
                                                        [*error description]]
                       where:_cmd];
        }
    }
}

- (NSData *)marshal:(id)source error:(NSError **)error {
    if (!source) {
        [AppDebugger log:@"source (GT_Settings) not set (is nil)"
                   where:_cmd];

        *error = [NSError errorWithDomain:@"de.beanfactory.settings"
                                     code:-1
                                 userInfo:@{NSLocalizedDescriptionKey : @"source (GT_Settings) not set (is nil)"}];
        return nil;
    }

    if (![source isKindOfClass:[GT_Settings class]]) {
        [AppDebugger log:[NSString stringWithFormat:@"source is not of kind GT_Settings. %@", [source class]]
                   where:_cmd];
        *error = [NSError errorWithDomain:@"de.beanfactory.settings"
                                     code:-2
                                 userInfo:@{NSLocalizedDescriptionKey : [NSString stringWithFormat:@"source is not of kind GT_Settings. %@", [source class]]}];
        return nil;
    }

    NSData *data = [NSJSONSerialization dataWithJSONObject:source
                                           options:0
                                             error:error];

    return data;
}


@end