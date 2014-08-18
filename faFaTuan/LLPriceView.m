//
//  LLPriceView.m
//  faFaTuan
//
//  Created by git on 14-8-18.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLPriceView.h"

@implementation LLPriceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGSize priceSize =[self getSizeForWith:_price.text fontSize:14.0];
    [_price setFrame:CGRectMake(_price.X, _price.Y, priceSize.width, _price.H)];
    //由于有一部分文字显示不全（计算宽度不准确）  只能用这种方法了
    if (IOS7_OR_LATER) {
        [_price.text drawInRect:_price.frame withAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:8.0/255 green:183.0/255  blue:158.0/255 alpha:1],NSFontAttributeName: [UIFont systemFontOfSize:14.0]}];
    }else{
        [[UIColor colorWithRed:8.0/255 green:183.0/255  blue:158.0/255 alpha:1]setFill];
        [_price.text drawInRect:_price.frame withFont:[UIFont systemFontOfSize:14.0]];
    }
    
    [_priceUnit setFrame:CGRectMake(_price.endX, _priceUnit.Y, _priceUnit.W, _priceUnit.H)];
    
    CGSize originaSize =[self getSizeForWith:_originaPrice.text fontSize:11.0];
    [_originaPrice setFrame:CGRectMake(_priceUnit.endX+5, _originaPrice.Y, originaSize.width, _originaPrice.H)];
    
    if (IOS7_OR_LATER) {
        [_originaPrice.text drawInRect:_originaPrice.frame withAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName: [UIFont systemFontOfSize:11.0]}];
    }else{
        [[UIColor lightGrayColor]setFill];
        [_originaPrice.text drawInRect:_originaPrice.frame withFont:[UIFont systemFontOfSize:11.0]];
    }
    [self drawLine:_originaPrice];
}
/**
 *  计算文字的宽高
 */
-(CGSize)getSizeForWith:(NSString *)value fontSize:(float)fontSize
{
    return [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(320, 15) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
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
