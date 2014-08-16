//
//  LLLine.m
//  faFaTuan
//
//  Created by git on 14-8-16.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLLine.h"

@implementation LLLine

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
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //指定直线样式
    CGContextSetLineCap(context,kCGLineCapSquare);
    //直线宽度
    CGContextSetLineWidth(context,1.0);
    //设置颜色
    CGContextSetRGBStrokeColor(context,190.0/255.0, 190.0/255.0, 190.0/255.0, 1.0);
    //开始绘制
    CGContextBeginPath(context);
    //画笔移动到点(31,170)
    CGContextMoveToPoint(context,0,self.frame.size.height/2);
    //下一点
    CGContextAddLineToPoint(context,self.frame.size.width,self.frame.size.height/2);
    //绘制完成
    CGContextStrokePath(context);
}


@end
