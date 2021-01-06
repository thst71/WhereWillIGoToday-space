//
//  KlasseTableCell.h
//  WhereWillIGoToday
//
//  Created by Thomas Strauß on 24.02.15.
//  Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BFSignalDotView.h"
#import "BFSignalBar.h"

@interface KlasseTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *klasse;
@property (weak, nonatomic) IBOutlet UILabel *entryCount;
@property (weak, nonatomic) IBOutlet UILabel *faecher;
@property (weak, nonatomic) IBOutlet BFSignalBar *signalBar;

+ (NSString *)identifier;

-(void)setKlasse:(NSString*)klasse withEntries:(NSUInteger)anzahl
     andSubjects:(NSArray*)faecher;

-(void)setKlasse:(NSString*)klasse withEntries:(NSUInteger)anzahl
     description:(NSAttributedString *)atText
     andSubjects:(NSArray*)faecher;

@end


@interface Kurzeintrag : NSObject

@property (nonatomic) CGFloat modeid;
@property (strong, nonatomic) NSString *title;


+(instancetype)kurzeintragWithMode:(CGFloat)modeid andTitle:(NSString *)title;

@end
