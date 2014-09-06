//
//  UIImageView+extend.m
//  Train
//
//  Created by LTNET on 14-6-29.
//  Copyright (c) 2014年 wanglilong. All rights reserved.
//

#import "UIImageView+extend.h"

@implementation UIImageView (extend)
+(UIImageView*)allocInitWithRect:(CGRect)frame imgName:(NSString *)img view:(UIView *)views EdgeInsets:(UIEdgeInsets )ed{
    UIImageView *imgView =[[UIImageView alloc]initWithFrame:frame];
    UIImage *imgs =[UIImage imageNamed:img];
    imgs = [imgs resizableImageWithCapInsets:ed];
    [imgView setImage:imgs];
    [imgView setContentMode:UIViewContentModeScaleToFill];
    [views addSubview:imgView];
    return imgView;
}
+(UIImageView*)allocInitWithRect:(CGRect)frame imgName:(NSString *)img view:(UIView *)views{
    UIImageView *imgView =[[UIImageView alloc]initWithFrame:frame];
    [imgView setImage:[UIImage imageNamed:img]];
    [views addSubview:imgView];
    return imgView;
}
+(UIImageView*)allocInitWith:(CGPoint)center imgName:(NSString *)img view:(UIView *)views{
    UIImageView *imgView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:img]];
    [imgView setCenter:center];
    [views addSubview:imgView];
    return imgView;
}
+(UIImageView*)startAnimationAt:(UIView *)views{
    if (!views) {
        return nil;
    }
    UIImageView *myAnimatedView = [[UIImageView alloc]initWithFrame:CGRectMake((views.W-172.8)/2, ([[UIScreen mainScreen] bounds].size.height-64-50-194.4)/2, 172.8, 194.4)];
    //animationImages属性返回一个存放动画图片的数组
    myAnimatedView.animationImages = @[[UIImage imageNamed:@"icon_loading_animating_1"],
                                       [UIImage imageNamed:@"icon_loading_animating_2"]];
    myAnimatedView.animationDuration = 0.25; //浏览整个图片一次所用的时间
    myAnimatedView.animationRepeatCount = 0; // 0 = loops forever 动画重复次数
    [myAnimatedView startAnimating];
    [views addSubview:myAnimatedView];
    return myAnimatedView;
}
+(void)stopAnimation:(UIImageView *)myAnimatedView
{
    if (!myAnimatedView) {
        return ;
    }
    [myAnimatedView stopAnimating];
    [myAnimatedView removeFromSuperview];
}
@end
