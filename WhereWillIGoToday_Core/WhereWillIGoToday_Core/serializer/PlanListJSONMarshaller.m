//
// Created by Thomas Strauß on 19.01.15.
// Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import "PlanListJSONMarshaller.h"
#import "GT_Plan.h"
#import "AppDebugger.h"


@implementation PlanListJSONMarshaller {

}

- (void)unmarshal:(NSData *)data into:(id)target error:(NSError **)error {

    if (!target) {
        [AppDebugger log:@"target (NSMutableArray) not set (is nil)"
                   where:_cmd];

        *error = [NSError errorWithDomain:@"de.beanfactory.plan"
                                     code:-1
                                 userInfo:@{NSLocalizedDescriptionKey : @"target (NSMutableArray) not set (is nil)"}];
        return;
    }

    if (![target isKindOfClass:[NSMutableArray class]]) {
        [AppDebugger log:[NSString stringWithFormat:@"target is not of kind NSMutableArray. %@", [target class]]
                   where:_cmd];
        *error = [NSError errorWithDomain:@"de.beanfactory.plan"
                                     code:-2
                                 userInfo:@{NSLocalizedDescriptionKey : [NSString stringWithFormat:@"target is not of kind NSMutableArray. %@", [target class]]}];
        return;
    }

    NSMutableArray *planList = target;

    if (data) {

        id json = [NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingAllowFragments
                                                    error:error];

        if (json && [json isKindOfClass:[NSArray class]]) {
            NSArray *array = json;

            [array enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {

                if( object && [object isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dictionary = object;

                
                GT_Plan *plan = [[GT_Plan alloc] initWithJSONDictionary:dictionary];
                if (plan) {
                    [planList addObject:plan];
                }
                else {
                    *stop = YES;
                    *error = [NSError errorWithDomain:@"de.beanfactory.plan"
                                                 code:-3
                                             userInfo:@{NSLocalizedDescriptionKey : [NSString stringWithFormat:@"cannot parse index %ld: %@", (unsigned long)index, object]}];
                }
                }
            }];
        }
        else {
            [AppDebugger log:[NSString stringWithFormat:@"error %@",
                                                        [*error description]]
                       where:_cmd];
        }
    }
}

- (NSData *)marshal:(id)source error:(NSError **)error {

    NSArray *plans;

    if (!source) {
        plans = [NSArray array];
    }
    else if (![source isKindOfClass:[NSArray class]]) {
        [AppDebugger log:[NSString stringWithFormat:@"cannot serialize %@.", [source class]]
                   where:_cmd];
        *error = [NSError errorWithDomain:@"de.beanfactory.plan"
                                     code:-4
                                 userInfo:@{NSLocalizedDescriptionKey : [NSString stringWithFormat:@"cannot serialize %@.", [source class]]}];
        return nil;
    }
    else {
        plans = (NSArray *) source;
    }

    NSData *data;

    data = [NSJSONSerialization dataWithJSONObject:plans
                                           options:0
                                             error:error];

    return data;
}

@end
