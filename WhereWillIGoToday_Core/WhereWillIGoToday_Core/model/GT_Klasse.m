//
// Created by Thomas Strauß on 25.01.15.
// Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import "GT_Klasse.h"


@implementation GT_Klasse {

}

- (instancetype)initWithKlasse:(NSString *)klasse {
    self = [super init];
    if (self) {
        _klasse = klasse;
    }

    return self;
}

+ (instancetype)klasseWithKlasse:(NSString *)klasse {
    NSString *myKlasse = cleanKlasseString(klasse);
    if ([GT_Klasse isAValidKlasse:myKlasse]) {
        return [[self alloc] initWithKlasse:myKlasse];
    }

    return nil;
}

+ (BOOL)isAValidKlasse:(NSString *)klasse {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^(GTA|[\\:].*|[0][5-9][ABCDEF]|[QE][1234]$)"
                                                                           options:NSRegularExpressionCaseInsensitive error:&error];

    NSRange range;
    range.length = klasse.length;
    range.location = 0;

    NSArray *result = [regex matchesInString:klasse options:NSMatchingAnchored range:range];
    return result.count > 0;
}


- (BOOL)matches:(NSString *)planEntry {

    if ([planEntry isEqualToString:self.klasse]) {
        return YES;
    }

    return NO;
}

@end

NSString *cleanKlasseString(NSString *klasse) {
    // uppercase string
    NSMutableString *copy = [NSMutableString stringWithString:[klasse uppercaseString]];

    // if string starts with 1..9, add "0" as prefix
    switch([copy characterAtIndex:0]) {
        case '1' :
        case '2' :
        case '3' :
        case '4' :
        case '5' :
        case '6' :
        case '7' :
        case '8' :
        case '9' :
            [copy insertString:@"0" atIndex:0];
            break;
    }

    return [NSString stringWithString:copy];
}