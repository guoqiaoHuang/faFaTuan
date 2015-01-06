//
//  LLASIHelp.m
//  NetWork
//
//  Created by LTNET on 14-6-8.
//  Copyright (c) 2014年 wanglilong. All rights reserved.
//

#import "LLASIHelp.h"
#import "NSString+SBJSON.h"
#import "Reachability.h"
#import "ASIDownloadCache.h"

#import "MBProgressHUD.h"
#define API_URL_MAKE(_string_) [NSURL URLWithString:_string_]

@implementation LLASIHelp
+(ASIFormDataRequest *)requestWithURL:(NSString *)url paramDic:(NSDictionary *)params resultBlock:(getData)block cancelBlock:(cancelBlock)acancelBlock httpMethod:(NSString *)method{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==NotReachable) {
        SHOW(@"没有网络");
        return nil;
    }
    __weak ASIFormDataRequest *request;
    if ([method isEqualToString:@"POST"]) {
        request=[ASIFormDataRequest requestWithURL:API_URL_MAKE(url)];
        for (NSString *key in [params allKeys]) {
            [request setPostValue:[params objectForKey:key] forKey:key];
        }
    }else if ([method  isEqualToString:@"GET"]){
        url = [url stringByAppendingFormat:@"?"];
        for (NSString *key in [params allKeys]) {
            url = [url stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"%@=%@&",key,[params objectForKey:key]]];
        }
        url =[url substringToIndex:(url.length-1)];
        request = [ASIHTTPRequest requestWithURL: API_URL_MAKE(url)];
    }
    [request setCompletionBlock:^{
        NSString *str = [[request responseString] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        NSDictionary *dic = [str JSONValue];
        if (block!=nil && dic!=nil) {
            block(dic);
        }else{
            NSLog(@"json解析失败");
            if (acancelBlock!=nil) {
                acancelBlock();
            }
        }
    }];
    [request setFailedBlock:^{
        if (acancelBlock!=nil) {
            acancelBlock();
        }
    }];
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [request setCachePolicy:ASIFallbackToCacheIfLoadFailsCachePolicy];
    [request setSecondsToCache:60*60*24*7];
    [request setTimeOutSeconds:60];
    [request setValidatesSecureCertificate:NO];
    [request startAsynchronous];
    
    return request;
}
+(ASIFormDataRequest *)requestWithURLReInt:(NSString *)url paramDic:(NSDictionary *)params resultBlock:(getDataRe)block cancelBlock:(cancelBlock)acancelBlock httpMethod:(NSString *)method{
    MBProgressHUD *HUD =[[MBProgressHUD alloc]initWithWindow:[UIApplication sharedApplication].keyWindow];
	[[UIApplication sharedApplication].keyWindow addSubview:HUD];
	[HUD show:YES];
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==NotReachable) {
        SHOW(@"没有网络");
        return nil;
    }
    __weak ASIFormDataRequest *request;
    if ([method isEqualToString:@"POST"]) {
        request=[ASIFormDataRequest requestWithURL:API_URL_MAKE(url)];
        for (NSString *key in [params allKeys]) {
            [request setPostValue:[params objectForKey:key] forKey:key];
        }
    }else if ([method  isEqualToString:@"GET"]){
        url = [url stringByAppendingFormat:@"?"];
        for (NSString *key in [params allKeys]) {
            url = [url stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"%@=%@&",key,[params objectForKey:key]]];
        }
        url =[url substringToIndex:(url.length-1)];
        request = [ASIHTTPRequest requestWithURL: API_URL_MAKE(url)];
    }
    [request setCompletionBlock:^{
        [HUD hide:YES afterDelay:0.1];
        NSString *str = [[request responseString] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        int re = [str integerValue];
        if (block!=nil) {
            block(re);
        }else{
            NSLog(@"json解析失败");
            if (acancelBlock!=nil) {
                acancelBlock();
            }
        }
    }];
    [request setFailedBlock:^{
        [HUD hide:YES afterDelay:0.1];
        if (acancelBlock!=nil) {
            acancelBlock();
        }
    }];
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [request setCachePolicy:ASIFallbackToCacheIfLoadFailsCachePolicy];
    [request setSecondsToCache:60*60*24*7];
    [request setTimeOutSeconds:60];
    [request setValidatesSecureCertificate:NO];
    [request startAsynchronous];
    
    return request;
}

//    [[ASIDownloadCache sharedCache]clearCachedResponsesForStoragePolicy:ASICachePermanentlyCacheStoragePolicy];  清空缓存
@end