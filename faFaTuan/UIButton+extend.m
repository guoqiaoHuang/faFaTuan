//
//  UIButton+extend.m
//  control
//
//  Created by LTNET on 14-6-23.
//  Copyright (c) 2014年 wanglilong. All rights reserved.
//

#import "UIButton+extend.h"

@implementation UIButton (extend)
+(UIButton *)buttonWithFrame:(CGRect)frame
                        type:(UIButtonType) type
                       title:(NSString *)title
                        font:(int)font
                  titleColor:(UIColor *)color
                   normalImg:(NSString*)norImg
                     subview:(id)view
{
    return  [self buttonWithFrame:frame type:type title:title font:font titleColor:color normalImg:norImg selectedImg:nil tag:0 subview:view isStretch:NO];
}
+(UIButton *)buttonWithFrame:(CGRect)frame
                        type:(UIButtonType) type
                       title:(NSString *)title
                        font:(int)font
                  titleColor:(UIColor *)color
                   normalImg:(NSString*)norImg
                 selectedImg:(NSString*)selImg
                         tag:(int)tag
                     subview:(id)view
                   isStretch:(BOOL)isStretch

{
    UIEdgeInsets ed = {2.0f,2.0f,2.0f,2.0f};
    UIImage *norImgs =[[UIImage imageNamed:norImg]resizableImageWithCapInsets:ed];
    UIImage *selImgs =[[UIImage imageNamed:selImg]resizableImageWithCapInsets:ed];
    if (!isStretch) {
        norImgs =[UIImage imageNamed:norImg];
        selImgs =[UIImage imageNamed:selImg];

    }
    UIButton *btn = [self buttonWithFrame:frame type:type title:title font:[UIFont systemFontOfSize:font] titleColor:color normalImg:norImgs selectedImg:selImgs tag:tag subview:view];
    return btn;
}
+(UIButton *)buttonWithFrame:(CGRect)frame
                      type:(UIButtonType) type
                     title:(NSString *)title
                      font:(UIFont*)font
                titleColor:(UIColor *)color
                 normalImg:(UIImage*)norImg
               selectedImg:(UIImage*)selImg
                       tag:(int)tag
                   subview:(id)view

{
    UIButton *btn = [UIButton buttonWithType:type];
    [btn setFrame:frame];

    [btn.titleLabel setFont:font];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    //设置btn图片
    [btn setBackgroundImage:norImg forState:UIControlStateNormal];
    [btn setBackgroundImage:selImg forState:UIControlStateHighlighted];
    [btn setBackgroundImage:selImg forState:UIControlStateSelected];
    
    [btn setTag:tag];
    [view addSubview:btn];
    return btn;
}
@end
