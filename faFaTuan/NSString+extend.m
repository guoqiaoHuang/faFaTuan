//
//  NSString+extend.m
//  Light
//
//  Created by LTNET on 14-6-23.
//  Copyright (c) 2014年 wanglilong. All rights reserved.
//

#import "NSString+extend.h"

@implementation NSString (extend)
+(NSString *)uft8To:(NSString *)string
{
    return  [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
+(NSString *)uft8:(NSString *)string
{
    return  [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
@end
