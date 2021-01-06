//
//  Created by Cocoa JSON Editor
//  http://www.cocoajsoneditor.com
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

// Import
#import "GT_Plan.h"
#import "GT_PlanEntry.h"
#import "AppEnvironment.h"

@implementation GT_Plan

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
	id plandate_ = [dic objectForKey:@"plandate"];
	if([plandate_ isKindOfClass:[NSString class]])
	{
		self.key = plandate_;
	}

	id pages_ = [dic objectForKey:@"pages"];
	if([pages_ isKindOfClass:[NSNumber class]])
	{
		self.pages = [pages_ unsignedIntegerValue];
	}

	id motd_ = [dic objectForKey:@"motd"];
	if([motd_ isKindOfClass:[NSArray class]])
	{
		self.motd = motd_;
	}

	id data_ = [dic objectForKey:@"data"];
	if([data_ isKindOfClass:[NSArray class]])
	{
		NSMutableArray *array = [NSMutableArray array];
        NSUInteger keyIdx = 0;
		for(NSDictionary *itemDic in data_)
		{
			GT_PlanEntry *item = [[GT_PlanEntry alloc] initWithJSONDictionary:itemDic];
            item.key =  [@(keyIdx++) stringValue];
			[array addObject:item];
		}
		self.entries = [NSArray arrayWithArray:array];
	}

}

+ (id)planWithKey:(NSString *)string andMotd:(NSString *)motd {
    GT_Plan *plan = [[GT_Plan alloc] initWithKey:string created:[NSDate date] modified:nil];
    plan.motd = @[motd];
    return plan;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"%@", [super description]];
    [description appendFormat:@"self.pages=%lu", (unsigned long)self.pages];
    [description appendFormat:@", self.motd=%@", self.motd];
    [description appendFormat:@", self.entries=%@", self.entries];
    [description appendString:@">"];
    return description;
}


@end
