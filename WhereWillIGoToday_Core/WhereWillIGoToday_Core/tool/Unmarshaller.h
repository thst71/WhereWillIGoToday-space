//
// Created by Thomas Strauß on 19.01.15.
// Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol Unmarshaller    <NSObject>

-(void)unmarshal:(NSData *)data into:(id)target error:(NSError **)error;

@end