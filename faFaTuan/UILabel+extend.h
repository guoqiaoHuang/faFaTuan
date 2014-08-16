//
//  UILabel+extend.h
//  control
//
//  Created by LTNET on 14-6-23.
//  Copyright (c) 2014年 wanglilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (extend)
+(UILabel *)allocInitWith:(CGRect)frame title:(NSString *)title font:(float)font color:(UIColor*)color view:(UIView *)views;
@end
