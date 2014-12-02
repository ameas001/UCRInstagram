//
//  Cell.m
//  UCRInstagram
//
//  Created by Tony Albor on 2/8/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import "Cell.h"

@implementation Cells

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
