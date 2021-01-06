//
//  Created by Cocoa JSON Editor
//  http://www.cocoajsoneditor.com
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"


@interface GT_PlanEntry : Model



@property (strong, nonatomic) NSString *Klasse;
@property (strong, nonatomic) NSString *Stunde;
@property (strong, nonatomic) NSString *NeuVertreter;
@property (strong, nonatomic) NSString *NeuFach;
@property (strong, nonatomic) NSString *PlanRaum;
@property (strong, nonatomic) NSString *PlanLehrer;
@property (strong, nonatomic) NSString *Fach;
@property (strong, nonatomic) NSString *Art;
@property (strong, nonatomic) NSString *Bemerkung;

- (id) initWithJSONDictionary:(NSDictionary *)dic;
- (void) parseJSONDictionary:(NSDictionary *)dic;

- (NSString *)description;

@end
