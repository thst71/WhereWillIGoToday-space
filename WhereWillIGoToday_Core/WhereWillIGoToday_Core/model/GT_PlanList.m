//
// Created by Thomas Strauß on 19.01.15.
// Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import "GT_PlanList.h"
#import "PlanListJSONMarshaller.h"


@implementation GT_PlanList {

}

+ (id <Marshaller>)marshaller {
    return [[PlanListJSONMarshaller alloc] init];
}

+ (id <Unmarshaller>)unmarshaller {
    return [[PlanListJSONMarshaller alloc] init];
}

@end