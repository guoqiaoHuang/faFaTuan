//
//  UIImageView+extend.h
//  Train
//
//  Created by LTNET on 14-6-29.
//  Copyright (c) 2014年 wanglilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (extend)
+(UIImageView*)allocInitWithRect:(CGRect)frame imgName:(NSString *)img view:(UIView *)views;
+(UIImageView*)allocInitWithRect:(CGRect)frame imgName:(NSString *)img view:(UIView *)views EdgeInsets:(UIEdgeInsets )ed;
+(UIImageView*)allocInitWith:(CGPoint)center imgName:(NSString *)img view:(UIView *)views;

+(UIImageView*)startAnimationAt:(UIView *)views;
+(void)stopAnimation:(UIImageView *)myAnimatedView;
@end
