//
//  KlasseTableCell.m
//  WhereWillIGoToday
//
//  Created by Thomas Strauß on 24.02.15.
//  Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import "KlasseTableCell.h"

extern NSString *displayKlasse(NSString *rawKlasse);

@implementation KlasseTableCell

+ (NSString *)identifier {
    return @"klassecell";
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setKlasse:(NSString *)klasse withEntries:(NSUInteger)anzahl andSubjects:(NSArray *)faecherLst {
    self.klasse.text = klasse;
    self.entryCount.text = [NSString stringWithFormat:@"%lu", (unsigned long) anzahl];
    self.faecher.text = @"";

    for (Kurzeintrag *ke in faecherLst) {
        [self.signalBar addSignal:ke.title withMode:ke.modeid];
    };

}


- (void)setKlasse:(NSString *)klasse withEntries:(NSUInteger)anzahl description:(NSAttributedString *)atText andSubjects:(NSArray *)faecherLst {
    self.klasse.text = displayKlasse(klasse);
    self.entryCount.text = [NSString stringWithFormat:@"%lu", (unsigned long) anzahl];
    self.faecher.attributedText = atText;
    
    [self.signalBar clearSignals];
    
    for (Kurzeintrag *ke in faecherLst) {
        [self.signalBar addSignal:ke.title withMode:ke.modeid];
    };
    
    [self.signalBar layoutIfNeeded];
}


@end


@implementation Kurzeintrag

+(instancetype)kurzeintragWithMode:(CGFloat)modeid andTitle:(NSString *)title {
    Kurzeintrag *ke = [Kurzeintrag new];
    ke.modeid = modeid;
    ke.title = title;
    return ke;
}

@end

NSString *displayKlasse(NSString *rawKlasse) {
    NSString *result;
    
    if([rawKlasse hasPrefix:@"0"]) {
        result = [[rawKlasse substringFromIndex:1] lowercaseString];
    }
    else {
        result = rawKlasse;
    }
    
    return result;
}

