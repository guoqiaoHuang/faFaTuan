//
//  UIButton+extend.h
//  control
//
//  Created by LTNET on 14-6-23.
//  Copyright (c) 2014年 wanglilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (extend)
+(UIButton *)buttonWithFrame:(CGRect)frame
                        type:(UIButtonType) type
                       title:(NSString *)title
                        font:(int)font
                  titleColor:(UIColor *)color
                   normalImg:(NSString*)norImg
                     subview:(id)view;
+(UIButton *)buttonWithFrame:(CGRect)frame
                        type:(UIButtonType) type
                       title:(NSString *)title
                        font:(int)font
                  titleColor:(UIColor *)color
                   normalImg:(NSString*)norImg
                 selectedImg:(NSString*)selImg
                         tag:(int)tag
                     subview:(id)view
                   isStretch:(BOOL)isStretch;
+(UIButton *)buttonWithFrame:(CGRect)frame
                     type:(UIButtonType) type
                    title:(NSString *)title
                     font:(UIFont*)font
               titleColor:(UIColor *)color
                normalImg:(UIImage*)norImg
              selectedImg:(UIImage*)selImg
                      tag:(int)tag
                  subview:(id)view;

@end
