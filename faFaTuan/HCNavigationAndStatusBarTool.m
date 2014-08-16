//
//  HCNavigationAndStatusBarTool.m
//  FindTreasureGames
//
//  Created by NewNumber on 13-12-3.
//  Copyright (c) 2013年 王立龙. All rights reserved.
//

#import "HCNavigationAndStatusBarTool.h"

@implementation HCNavigationAndStatusBarTool
#pragma mark-
#pragma mark 设置导航栏
/*
 作用:为导航栏的标题设置颜色（Ios7)
 解决问题:ios7下导航栏的颜色默认为黑色的，并且不容易修改
 */
+(void)setNavigationTitleColor:(UIViewController *)selfs
{
    if (IOS7_OR_LATER) {
        NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
        [selfs.navigationController.navigationBar setTitleTextAttributes:attributes];
    }
}
/*
 自定义标题
 */
+(void)setNavigationTitle:(UIViewController *)selfs andTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
    titleLabel.textColor = [UIColor colorWithRed:(255.0/255.0) green:(255.0 / 255.0) blue:(255.0 / 255.0) alpha:1];  //设置文本颜色
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;  //设置标题
    selfs.navigationItem.titleView = titleLabel;
}
/*
 作用:为导航栏设置背景
 */
+(void)setNavigationBackground:(UIViewController *)selfs
{
    [selfs.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar"] forBarMetrics:UIBarMetricsDefault];
    return;
}
#pragma mark-
#pragma mark 自定义返回按钮

+(void)customLeftBackButton:(UIViewController *)selfs sel:(SEL)popself{
    UIImage *image=[UIImage imageNamed:@"btn_title_big_normal"];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, image.size.width*1.3, image.size.height*1.3);
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:selfs action:popself  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    selfs.navigationItem.leftBarButtonItem =backItem;
}
+(void)customRightBackButton:(UIViewController *)selfs sel:(SEL) popself{
    UIImage *image=[UIImage imageNamed:@"btn_title_big_normal1"];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, image.size.width*4/3, image.size.height*4/3);
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:selfs action:popself forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    selfs.navigationItem.rightBarButtonItem =backItem;
}
@end
