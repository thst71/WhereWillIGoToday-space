//
// Created by Thomas Strauß on 19.01.15.
// Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Marshaller <NSObject>

-(NSData*)marshal:(id)source error:(NSError**)error;

@end