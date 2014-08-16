//
//  LLBulkTableViewCell.m
//  faFaTuan
//
//  Created by git on 14-8-14.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLBulkTableViewCell.h"

@implementation LLBulkTableViewCell

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
- (void)drawRect:(CGRect)rect
{
    CGSize priceSize =[self getSizeForWith:_price.text fontSize:14.0 andWidth:200];
    [_price setFrame:CGRectMake(_price.X, _price.Y, priceSize.width, _price.H)];
    [_priceUnit setFrame:CGRectMake(_price.endX, _priceUnit.Y, _priceUnit.W, _priceUnit.H)];
    CGSize originaSize =[self getSizeForWith:_originaPrice.text fontSize:11 andWidth:200];
    [_originaPrice setFrame:CGRectMake(_priceUnit.endX+5, _originaPrice.Y, originaSize.width, _originaPrice.H)];
    [_lineView  setFrame:_originaPrice.frame];
}
-(CGSize)getSizeForWith:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    return [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
}
@end
