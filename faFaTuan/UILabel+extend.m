//
//  UILabel+extend.m
//  control
//
//  Created by LTNET on 14-6-23.
//  Copyright (c) 2014年 wanglilong. All rights reserved.
//

#import "UILabel+extend.h"

@implementation UILabel (extend)
+(UILabel *)allocInitWith:(CGRect)frame title:(NSString *)title font:(float)font color:(UIColor*)color view:(UIView *)views
{
    UILabel *lable =[[UILabel alloc]initWithFrame:frame];
    [lable setBackgroundColor:[UIColor clearColor]];
    lable.text=title;
    lable.font=[UIFont systemFontOfSize:font];
    lable.textColor =color;
    [views addSubview:lable];
    return lable;
}
@end
