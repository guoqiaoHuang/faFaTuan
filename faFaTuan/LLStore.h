//
//  LLStore.h
//  faFaTuan
//
//  Created by git on 14-9-10.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLStore : NSObject
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *passWord;
+(LLStore *)allocInit;
@end
