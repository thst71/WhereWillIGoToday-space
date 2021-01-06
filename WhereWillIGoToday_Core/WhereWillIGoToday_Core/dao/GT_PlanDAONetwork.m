//
// Created by Thomas Strauß on 14.01.15.
// Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import "GT_PlanDAONetwork.h"
#import "AppDebugger.h"
#import "GT_PlanList.h"
#import "GT_Plan.h"


@implementation GT_PlanDAONetwork

- (NSMutableArray *)loadData:(NSError **)err {
    [AppDebugger log:self
               where:_cmd];

    NSBundle *settings = [NSBundle mainBundle];

    NSString *server = APP_SETTING_SERVERURL;//[[settings infoDictionary] objectForKey:APP_SETTING_SERVERURL];

    NSURL *url = [[NSURL alloc] initWithString:server];

    NSError *error = nil;

    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:100000];

    NSURLResponse *response = nil;

    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    *err = error;

    if (!data) {
        return nil;
    }

    if (error) {
        return nil;
    }

    NSMutableArray *result = [NSMutableArray array];

    id<Unmarshaller>unm = [GT_PlanList unmarshaller];
    [unm unmarshal:data into:result error:&error];
    *err = error;

    if (error) {
        return nil;
    }

    if([data writeToFile:path() options:NSAtomicWrite error:err]) {
        return result;
    }

    // local save failed.
    return nil;
}

- (void)persist:(Callback)callback model:(Model *)model {
    [super persist:callback
             model:model];
}

- (void)find:(Callback)callback byKey:(NSString *)key {
    NSError *err = nil;

    NSMutableArray *data = [self loadData:&err];
    if(!data && err) {
        forward(callback, err, true);
        return;
    }

    if( err ) {
        forward(callback, err, true);
        return;
    }

    if(!data) {
        forward(callback, APP_ERROR_NO_DATA, true);
        return;
    }

    __block GT_Plan *hit = nil;


    [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        hit = [((GT_Plan *) obj).key isEqualToString:key] ? obj : hit;
        *stop = (hit!=nil);
    }];

    forward(callback, hit, false);
}

- (void)find:(Callback)callback limit:(Limit *)limit {
    [self find:callback query:nil limit:limit];
}


- (void)find:(Callback)callback query:(Query *)query limit:(Limit *)limit {
    NSError *err = nil;

    NSMutableArray *data = [self loadData:&err];
    if(!data && err) {
        forward(callback, err, true);
        return;
    }

    if( err ) {
        forward(callback, err, true);
        return;
    }

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

- (void)startup {

}

- (void)shutdown {

}



@end
