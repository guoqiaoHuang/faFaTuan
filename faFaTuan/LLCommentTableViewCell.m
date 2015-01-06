//
//  LLCommentTableViewCell.m
//  faFaTuan
//
//  Created by git on 14-12-31.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLCommentTableViewCell.h"

@implementation LLCommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews
{
    CGSize commentSize =[NSString getSizeForWith:_commentLable.text fontSize:14.0];
    [_commentLable setFrame:CGRectMake(_commentLable.X, _commentLable.Y, _commentLable.W, commentSize.height)];
    [_commentTime setFrame:CGRectMake(_commentTime.X, _commentLable.endY+10,_commentTime.W,_commentTime.H)];
    [self setFrame:CGRectMake(self.X, self.Y, self.W, _commentTime.endY+10)];
    [_lineImageView setFrame:CGRectMake(0,self.H-1, self.W, 2)];
}
@end
