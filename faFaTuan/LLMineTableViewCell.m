//
//  LLMineTableViewCell.m
//  faFaTuan
//
//  Created by git on 14-9-12.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLMineTableViewCell.h"

@implementation LLMineTableViewCell

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
    [_titleText sizeToFit];
    [_subtitle sizeToFit];
    [_subtitle setFrame:CGRectMake(_titleText.endX+10, _subtitle.Y, _subtitle.W, _subtitle.H)];
    
}
@end
