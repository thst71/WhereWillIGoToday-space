//
//  Created by Cocoa JSON Editor
//  http://www.cocoajsoneditor.com
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

// Import
#import "GT_PlanEntry.h"


@implementation GT_PlanEntry




- (void) dealloc
{
	

}

- (id) initWithJSONDictionary:(NSDictionary *)dic
{
	if(self = [super init])
	{
		[self parseJSONDictionary:dic];
	}
	
	return self;
}

- (void) parseJSONDictionary:(NSDictionary *)dic
{
	// PARSER
	id Klasse_ = [dic objectForKey:@"Klasse"];
	if([Klasse_ isKindOfClass:[NSString class]])
	{
		self.Klasse = Klasse_;
	}

	id Stunde_ = [dic objectForKey:@"Stunde"];
	if([Stunde_ isKindOfClass:[NSString class]])
	{
		self.Stunde = Stunde_;
	}

	id NeuVertreter_ = [dic objectForKey:@"NeuVertreter"];
	if([NeuVertreter_ isKindOfClass:[NSString class]])
	{
		self.NeuVertreter = NeuVertreter_;
	}

	id NeuFach_ = [dic objectForKey:@"NeuFach"];
	if([NeuFach_ isKindOfClass:[NSString class]])
	{
		self.NeuFach = NeuFach_;
	}

	id PlanRaum_ = [dic objectForKey:@"PlanRaum"];
	if([PlanRaum_ isKindOfClass:[NSString class]])
	{
		self.PlanRaum = PlanRaum_;
	}

	id PlanLehrer_ = [dic objectForKey:@"PlanLehrer"];
	if([PlanLehrer_ isKindOfClass:[NSString class]])
	{
		self.PlanLehrer = PlanLehrer_;
	}

	id Fach_ = [dic objectForKey:@"Fach"];
	if([Fach_ isKindOfClass:[NSString class]])
	{
		self.Fach = Fach_;
	}

	id Art_ = [dic objectForKey:@"Art"];
	if([Art_ isKindOfClass:[NSString class]])
	{
		self.Art = Art_;
	}

	id Bemerkung_ = [dic objectForKey:@"Bemerkung"];
	if([Bemerkung_ isKindOfClass:[NSString class]])
	{
		self.Bemerkung = Bemerkung_;
	}

	
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"%@", [super description]];
    [description appendFormat:@"self.GT_Klasse=%@", self.Klasse];
    [description appendFormat:@", self.Stunde=%@", self.Stunde];
    [description appendFormat:@", self.NeuVertreter=%@", self.NeuVertreter];
    [description appendFormat:@", self.NeuFach=%@", self.NeuFach];
    [description appendFormat:@", self.PlanRaum=%@", self.PlanRaum];
    [description appendFormat:@", self.PlanLehrer=%@", self.PlanLehrer];
    [description appendFormat:@", self.Fach=%@", self.Fach];
    [description appendFormat:@", self.Art=%@", self.Art];
    [description appendFormat:@", self.Bemerkung=%@", self.Bemerkung];
    [description appendString:@">"];
    return description;
}

@end
