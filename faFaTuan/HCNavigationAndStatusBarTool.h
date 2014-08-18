//
//  HCNavigationAndStatusBarTool.h
//  FindTreasureGames
//
//  Created by NewNumber on 13-12-3.
//  Copyright (c) 2013年 王立龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCNavigationAndStatusBarTool : NSObject
/**
 * 功能：设置导航栏标题颜色
 * 参数：controller  当前的viewController
 */
+(void)setNavigationTitleColor:(UIViewController *)controller;
/**
 * 功能：自定义标题
 * 参数：selfs  当前的viewController
 *      title 标题
 */
+(void)setNavigationTitle:(UIViewController *)selfs andTitle:(NSString *)title;
/**
 * 功能：为导航栏设置背景
 * 参数：controller  当前的viewController
 */
+(void)setNavigationBackground:(UIViewController *)controller;
/**
 * 功能：设置返回按钮
 * 参数：selfs  当前的viewController
 *      popself 选择器
 */
+(void)customLeftBackButton:(UIViewController *)selfs sel:(SEL)popself;
+(void)customRightBackButton:(UIViewController *)selfs sel:(SEL) popself;
@end
