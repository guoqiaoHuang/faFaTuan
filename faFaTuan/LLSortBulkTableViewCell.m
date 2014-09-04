//
//  LLSortBulkTableViewCell.m
//  faFaTuan
//
//  Created by git on 14-9-2.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLSortBulkTableViewCell.h"

@implementation LLSortBulkTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews
{
    [_priceViews setNeedsDisplay];
}

@end
