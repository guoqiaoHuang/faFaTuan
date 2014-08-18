//
//  LLASIHelp.h
//  NetWork
//
//  Created by LTNET on 14-6-8.
//  Copyright (c) 2014年 wanglilong. All rights reserved.
//
typedef void(^getData)(NSDictionary *dic);
typedef void(^cancelBlock)(void);
#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
@interface LLASIHelp : NSObject
/**
    网络请求（自动缓存）
    url   网址
    params 键值对
    block  结果回调
    method  网络请求方法
 */
+(ASIFormDataRequest *)requestWithURL:(NSString *)url paramDic:(NSDictionary *)params resultBlock:(getData)block cancelBlock:(cancelBlock)acancelBlock httpMethod:(NSString *)method;
@end
