//
//  MemoTableViewCell.m
//  Basho-memo
//
//  Created by KoichiSAKURAI on 2014/03/04.
//  Copyright (c) 2014年 40rce. All rights reserved.
//

#import "MemoTableViewCell.h"

@implementation MemoTableViewCell

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
