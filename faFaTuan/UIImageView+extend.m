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
@end
