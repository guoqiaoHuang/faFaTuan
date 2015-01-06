//
//  LLMeTableViewCell.m
//  faFaTuan
//
//  Created by git on 14-9-9.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLMeTableViewCell.h"

@implementation LLMeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

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
    if (!IOS7_OR_LATER) {
        [_myHeaderView setFrame:CGRectMake(15, _myHeaderView.Y, _myHeaderView.W, _myHeaderView.H)];
    }
}
@end
