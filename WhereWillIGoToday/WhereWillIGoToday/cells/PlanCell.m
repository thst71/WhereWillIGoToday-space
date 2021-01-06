//
// Created by Thomas Strauß on 23.02.15.
// Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import "PlanCell.h"


@implementation PlanCell {

}
+ (NSString *)identifier {
    return @"plancell";
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@implementation HeaderCell {

}
+ (NSString *)identifier {
    return @"headercell";
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end