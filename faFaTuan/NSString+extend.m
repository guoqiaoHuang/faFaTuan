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
//提取字符串中的URL
+(NSMutableArray *)getUrls:(NSString *)urlString
{
    if (urlString==nil){
        return nil;
    }

    NSMutableArray *ary = [[NSMutableArray alloc]init];
    NSError *error;
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:urlString options:0 range:NSMakeRange(0, [urlString length])];
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSString* substringForMatch = [urlString substringWithRange:match.range];
        [ary addObject: substringForMatch];
    }
    return ary;
}
/**
 *  计算文字的宽高
 */
+(CGSize)getSizeForWith:(NSString *)value fontSize:(float)fontSize
{
    return [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(320, 300) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
}
+(NSString *)removeNoUseZero:(NSString*) str
{
    if ([str rangeOfString:@"."].location==NSNotFound) {
        return str;
    }else{
        NSString *strOut =[str substringFromIndex:str.length-1];
        if ([strOut isEqualToString:@"0"]) {
            return [NSString removeNoUseZero:[str substringToIndex:str.length-1]];
        }else if ([strOut isEqualToString:@"."]){
            return [str substringToIndex:str.length-1];
        }else{
            return str;
        }
    }
}

@end
