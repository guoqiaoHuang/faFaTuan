//
//  LLMerchTableViewCell.m
//  faFaTuan
//
//  Created by git on 14-12-25.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLMerchTableViewCell.h"

@implementation LLMerchTableViewCell

- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)drawRect:(CGRect)rect
{
    [self drawLine:_beforePriceLable ];
}
-(void)layoutSubviews
{
    
    CGSize priceSize =[NSString getSizeForWith:_nowPriceLable.text fontSize:12.0];
    [_nowPriceLable setFrame:CGRectMake(_nowPriceLable.X, _nowPriceLable.Y, priceSize.width+10, 21)];
    
    [_yuanLable setFrame:CGRectMake(_nowPriceLable.endX, _yuanLable.Y, _yuanLable.W, 21)];
    CGSize beforePriceSize =[NSString getSizeForWith:_beforePriceLable.text fontSize:12.0];
    [_beforePriceLable setFrame:CGRectMake(_yuanLable.endX, _beforePriceLable.Y, beforePriceSize.width, 21)];
}
/**
 *  在view中间画一条直线
 */
-(void)drawLine:(UIView *)view
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context,kCGLineCapSquare);
    CGContextSetLineWidth(context,1.0);
    CGContextSetRGBStrokeColor(context,190.0/255.0, 190.0/255.0, 190.0/255.0, 1.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context,view.X,view.Y+view.H/2);
    CGContextAddLineToPoint(context,view.X+view.W,view.Y+view.H/2);
    CGContextStrokePath(context);
}
@end
