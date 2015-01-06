//
//  LLStore.m
//  faFaTuan
//
//  Created by git on 14-9-10.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLStore.h"

@implementation LLStore
+(LLStore *)allocInit
{
    static LLStore *store;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[LLStore alloc] init];
    });
    return store;
}
@end
