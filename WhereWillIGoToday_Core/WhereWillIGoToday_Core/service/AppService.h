//
// Created by Frank Bahn on 17.12.14.
// Copyright (c) 2014 fb-it-solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAOWrapper.h"
#import "Lifecycle.h"
#import "AppDevice.h"
#import "AppEnvironment.h"
#import "Limit.h"
#import "Query.h"
#import "Model.h"
#import "GT_Klasse.h"

@class ModelDAO;

@interface AppService : NSObject <Lifecycle>

@property(strong, readonly) AppDevice *device;

- (void)persist:(Callback)callback model:(Model *)model;

- (void)find:(Callback)callback byKey:(NSString *)key forClass:(Class)clazz;

- (void)find:(Callback)callback limit:(Limit *)limit forClass:(Class)clazz;

- (void)find:(Callback)callback query:(Query *)query limit:(Limit *)limit forClass:(Class)clazz;

- (void)findAllPlans:(Callback)callback;

- (instancetype)initWithDevice:(AppDevice *)device;

+ (instancetype)serviceWithDevice:(AppDevice *)device;

- (DAOWrapper *)register:(DAOWrapper *)wrapper forClass:(Class)clazz;

@end