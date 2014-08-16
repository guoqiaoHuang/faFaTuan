//
//  HCNavigationAndStatusBarTool.h
//  FindTreasureGames
//
//  Created by NewNumber on 13-12-3.
//  Copyright (c) 2013年 王立龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCNavigationAndStatusBarTool : NSObject
///设置导航栏
+(void)setNavigationTitleColor:(UIViewController *)controller;
///自定义标题
+(void)setNavigationTitle:(UIViewController *)selfs andTitle:(NSString *)title;
///作用:为导航栏设置背景
+(void)setNavigationBackground:(UIViewController *)controller;
///设置返回按钮
+(void)customLeftBackButton:(UIViewController *)selfs sel:(SEL)popself;
+(void)customRightBackButton:(UIViewController *)selfs sel:(SEL) popself;
@end
