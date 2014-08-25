//
//  NSString+extend.h
//  Light
//
//  Created by LTNET on 14-6-23.
//  Copyright (c) 2014年 wanglilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (extend)

+(NSString *)uft8To:(NSString *)string;
+(NSString *)uft8:(NSString *)string;
/**
   提取字符串中的URL
 */
+(NSMutableArray *)getUrls:(NSString *)urlString;
/**
 *  计算文字的宽高
 */
+(CGSize)getSizeForWith:(NSString *)value fontSize:(float)fontSize;
/**
 *  去除无效的零
 */
+(NSString *)removeNoUseZero:(NSString*) str;
@end
